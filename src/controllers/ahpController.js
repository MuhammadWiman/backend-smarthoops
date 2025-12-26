const db = require('../config/db');

exports.hitungAHP = (req, res) => {
  // 1. Ambil data kriteria untuk menentukan dimensi matriks [cite: 41-45]
  db.query('SELECT * FROM kriteria ORDER BY id_kriteria', (err, kriteria) => {
    if (err) return res.status(500).json(err);

    /**
     * Mengambil nilai perbandingan dari SEMUA pelatih dan menggabungkannya 
     * dengan rumus Geometric Mean: EXP(AVG(LN(nilai))) 
     */
    const queryKonsensus = `
      SELECT 
        kriteria_1, 
        kriteria_2, 
        EXP(AVG(LN(nilai))) as nilai_konsensus
      FROM perbandingan_kriteria 
      GROUP BY kriteria_1, kriteria_2
    `;

    db.query(queryKonsensus, (err, perbandingan) => {
      if (err) return res.status(500).json(err);

      const n = kriteria.length;
      // Inisialisasi matriks n x n dengan nilai default 1 
      const matrix = Array.from({ length: n }, () => Array(n).fill(1));

      // Map id_kriteria ke index array untuk akses cepat
      const indexMap = {};
      kriteria.forEach((k, i) => {
        indexMap[k.id_kriteria] = i;
      });

      // 3. Masukkan nilai konsensus (hasil gabungan pelatih) ke dalam matriks 
      perbandingan.forEach(p => {
        const i = indexMap[p.kriteria_1];
        const j = indexMap[p.kriteria_2];

        if (i !== undefined && j !== undefined) {
          const val = Number(p.nilai_konsensus);
          matrix[i][j] = val;
          // Automatis mengisi nilai kebalikan (reciprocal) 
          matrix[j][i] = 1 / val;
        }
      });

      // 4. Hitung Jumlah Kolom untuk normalisasi [cite: 71-73]
      const colSum = Array(n).fill(0);
      for (let j = 0; j < n; j++) {
        for (let i = 0; i < n; i++) {
          colSum[j] += matrix[i][j];
        }
      }

      // 5. Normalisasi Matriks & Hitung Eigenvector (Bobot Prioritas) [cite: 71-73]
      const bobot = matrix.map(row =>
        row.reduce((sum, val, idx) => sum + (val / (colSum[idx] || 1)), 0) / n
      );

      // 6. Hapus bobot lama dan simpan bobot konsensus yang baru [cite: 71-73]
      db.query('DELETE FROM bobot_kriteria', (deleteErr) => {
        if (deleteErr) return res.status(500).json(deleteErr);

        const insertValues = bobot.map((bobotValue, index) => {
          const id_kriteria = kriteria[index].id_kriteria;
          return [id_kriteria, bobotValue.toFixed(4)];
        });

        const insertQuery = 'INSERT INTO bobot_kriteria (id_kriteria, bobot) VALUES ?';
        
        db.query(insertQuery, [insertValues], (insertErr, result) => {
          if (insertErr) return res.status(500).json(insertErr);

          // 7. Format detail bobot untuk keperluan tampilan Frontend 
          const detailBobot = kriteria.map((k, index) => ({
            id_kriteria: k.id_kriteria,
            nama_kriteria: k.nama_kriteria,
            bobot: bobot[index].toFixed(4),
            persentase: (bobot[index] * 100).toFixed(2) + '%'
          }));

          res.json({
            success: true,
            message: 'Bobot konsensus (Multi-Evaluator) berhasil dihitung',
            total_kriteria: n,
            detail_bobot: detailBobot,
            matrix_konsensus: matrix
          });
        });
      });
    });
  });
};