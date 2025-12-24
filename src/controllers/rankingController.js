const db = require('../config/db');

exports.hitungRanking = (req, res) => {
  // 1️⃣ Ambil kriteria
  db.query('SELECT * FROM kriteria ORDER BY id_kriteria', (err, kriteria) => {
    if (err) return res.status(500).json(err);

    // 2️⃣ Ambil perbandingan kriteria
    db.query('SELECT * FROM perbandingan_kriteria', (err, perbandingan) => {
      if (err) return res.status(500).json(err);

      const n = kriteria.length;
      const matrix = Array.from({ length: n }, () => Array(n).fill(1));

      // 🔑 Mapping id_kriteria → index matrix
      const indexMap = {};
      kriteria.forEach((k, i) => {
        indexMap[k.id_kriteria] = i;
      });

      // 3️⃣ Bangun matriks AHP
      perbandingan.forEach(p => {
        const i = indexMap[p.kriteria_1];
        const j = indexMap[p.kriteria_2];

        if (i !== undefined && j !== undefined) {
          matrix[i][j] = Number(p.nilai);
          matrix[j][i] = 1 / Number(p.nilai);
        }
      });

      // 4️⃣ Hitung bobot AHP
      const colSum = Array(n).fill(0);
      for (let j = 0; j < n; j++) {
        for (let i = 0; i < n; i++) {
          colSum[j] += matrix[i][j];
        }
      }

      const bobot = matrix.map(row =>
        row.reduce((sum, val, idx) => sum + val / colSum[idx], 0) / n
      );

      // 5️⃣ Ambil nilai pemain (TABEL penilaian)
      db.query(
        `SELECT 
            p.id_pemain,
            pm.nama,
            p.id_kriteria,
            p.nilai
         FROM penilaian p
         JOIN pemain pm ON pm.id_pemain = p.id_pemain`,
        (err, rows) => {
          if (err) return res.status(500).json(err);

          const hasil = {};

          // 6️⃣ Hitung nilai akhir pemain
          rows.forEach(r => {
            if (!hasil[r.id_pemain]) {
              hasil[r.id_pemain] = {
                id_pemain: r.id_pemain,
                nama_pemain: r.nama,  // Diubah dari r.nama_pemain ke r.nama
                total: 0
              };
            }

            const idx = indexMap[r.id_kriteria];
            if (idx !== undefined) {
              hasil[r.id_pemain].total += r.nilai * bobot[idx];
            }
          });

          // 7️⃣ Urutkan ranking
          const ranking = Object.values(hasil)
            .sort((a, b) => b.total - a.total)
            .map((r, i) => ({
              ranking: i + 1,
              id_pemain: r.id_pemain,
              nama_pemain: r.nama_pemain,
              nilai_akhir: parseFloat(r.total.toFixed(2)) // Konversi ke float
            }));

          // 8️⃣ Hapus data lama dari tabel hasil_ahp
          db.query('DELETE FROM hasil_ahp', (deleteErr) => {
            if (deleteErr) return res.status(500).json(deleteErr);

            // 9️⃣ Siapkan data untuk insert ke tabel hasil_ahp
            const insertValues = ranking.map(r => [
              r.id_pemain,
              r.nilai_akhir,
              r.ranking
            ]);

            // 🔟 Insert data ranking ke tabel hasil_ahp
            const insertQuery = 'INSERT INTO hasil_ahp (id_pemain, nilai_akhir, ranking) VALUES ?';
            
            db.query(insertQuery, [insertValues], (insertErr, result) => {
              if (insertErr) return res.status(500).json(insertErr);

              res.json({
                message: 'Perhitungan ranking berhasil dan data disimpan',
                data_ranking: ranking,
                total_pemain: ranking.length,
                inserted_rows: result.affectedRows
              });
            });
          });
        }
      );
    });
  });
};