const db = require('../config/db');

exports.hitungRanking = (req, res) => {
  // 1️⃣ Ambil kriteria (6 Skill & 6 Fisik sesuai prototype) [cite: 45-58]
  db.query('SELECT * FROM kriteria ORDER BY id_kriteria', (err, kriteria) => {
    if (err) return res.status(500).json(err);

    /** * 2️⃣ Ambil Konsensus Perbandingan Kriteria (Geometric Mean)
     * Menggabungkan penilaian dari SEMUA pelatih [cite: 6, 63-67]
     */
    const queryKonsensusKriteria = `
      SELECT 
        kriteria_1, 
        kriteria_2, 
        EXP(AVG(LN(nilai))) as nilai_konsensus
      FROM perbandingan_kriteria 
      GROUP BY kriteria_1, kriteria_2
    `;

    db.query(queryKonsensusKriteria, (err, perbandingan) => {
      if (err) return res.status(500).json(err);

      const n = kriteria.length;
      const matrix = Array.from({ length: n }, () => Array(n).fill(1));

      // Mapping id_kriteria → index matrix
      const indexMap = {};
      kriteria.forEach((k, i) => {
        indexMap[k.id_kriteria] = i;
      });

      // 3️⃣ Bangun matriks AHP dari hasil Konsensus 
      perbandingan.forEach(p => {
        const i = indexMap[p.kriteria_1];
        const j = indexMap[p.kriteria_2];

        if (i !== undefined && j !== undefined) {
          const val = Number(p.nilai_konsensus);
          matrix[i][j] = val;
          matrix[j][i] = 1 / val;
        }
      });

      // 4️⃣ Hitung bobot AHP (Normalisasi & Eigenvector) [cite: 71-73]
      const colSum = Array(n).fill(0);
      for (let j = 0; j < n; j++) {
        for (let i = 0; i < n; i++) {
          colSum[j] += matrix[i][j];
        }
      }

      const bobot = matrix.map(row =>
        row.reduce((sum, val, idx) => sum + (val / (colSum[idx] || 1)), 0) / n
      );

      /**
       * 5️⃣ Ambil Rata-rata Nilai Pemain dari SEMUA Pelatih 
       * Menggabungkan skor performa pemain agar lebih objektif
       */
      const queryRataNilaiPemain = `
        SELECT 
            p.id_pemain,
            pm.nama,
            p.id_kriteria,
            AVG(p.nilai) as nilai_rata_rata
        FROM penilaian p
        JOIN pemain pm ON pm.id_pemain = p.id_pemain
        GROUP BY p.id_pemain, p.id_kriteria
      `;

      db.query(queryRataNilaiPemain, (err, rows) => {
        if (err) return res.status(500).json(err);

        const hasil = {};

        // 6️⃣ Hitung nilai akhir pemain (Skor Rata-rata * Bobot Konsensus) [cite: 71-73]
        rows.forEach(r => {
          if (!hasil[r.id_pemain]) {
            hasil[r.id_pemain] = {
              id_pemain: r.id_pemain,
              nama_pemain: r.nama,
              total: 0
            };
          }

          const idx = indexMap[r.id_kriteria];
          if (idx !== undefined) {
            // Kontribusi nilai kriteria ke skor akhir [cite: 73, 79]
            hasil[r.id_pemain].total += Number(r.nilai_rata_rata) * bobot[idx];
          }
        });

        // 7️⃣ Urutkan ranking pemain terbaik [cite: 74-78]
        const ranking = Object.values(hasil)
          .sort((a, b) => b.total - a.total)
          .map((r, i) => ({
            ranking: i + 1,
            id_pemain: r.id_pemain,
            nama_pemain: r.nama_pemain,
            nilai_akhir: parseFloat(r.total.toFixed(4)) // Presisi lebih tinggi untuk ranking
          }));

        // 8️⃣ Hapus data lama dari tabel hasil_ahp [cite: 71]
        db.query('DELETE FROM hasil_ahp', (deleteErr) => {
          if (deleteErr) return res.status(500).json(deleteErr);

          if (ranking.length === 0) {
            return res.json({ message: 'Tidak ada data penilaian untuk dihitung', data_ranking: [] });
          }

          // 9️⃣ Siapkan data untuk insert 
          const insertValues = ranking.map(r => [
            r.id_pemain,
            r.nilai_akhir,
            r.ranking
          ]);

          // 🔟 Simpan hasil ranking final ke database [cite: 71-74]
          const insertQuery = 'INSERT INTO hasil_ahp (id_pemain, nilai_akhir, ranking) VALUES ?';
          
          db.query(insertQuery, [insertValues], (insertErr, result) => {
            if (insertErr) return res.status(500).json(insertErr);

            res.json({
              success: true,
              message: 'Perhitungan ranking multi-evaluator berhasil disimpan',
              data_ranking: ranking,
              total_pemain: ranking.length,
              status: "Konsensus Tercapai"
            });
          });
        });
      });
    });
  });
};