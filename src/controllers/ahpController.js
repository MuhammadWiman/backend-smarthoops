const db = require('../config/db');

exports.hitungAHP = (req, res) => {
  db.query('SELECT * FROM kriteria ORDER BY id_kriteria', (err, kriteria) => {
    if (err) return res.status(500).json(err);

    db.query('SELECT * FROM perbandingan_kriteria', (err, perbandingan) => {
      if (err) return res.status(500).json(err);

      const n = kriteria.length;
      const matrix = Array.from({ length: n }, () => Array(n).fill(1));

      // 🔑 MAP id_kriteria → index matrix
      const indexMap = {};
      kriteria.forEach((k, i) => {
        indexMap[k.id_kriteria] = i;
      });

      perbandingan.forEach(p => {
        const i = indexMap[p.kriteria_1];
        const j = indexMap[p.kriteria_2];

        if (i !== undefined && j !== undefined) {
          matrix[i][j] = Number(p.nilai);
          matrix[j][i] = 1 / Number(p.nilai);
        }
      });

      // Hitung jumlah kolom
      const colSum = Array(n).fill(0);
      for (let j = 0; j < n; j++) {
        for (let i = 0; i < n; i++) {
          colSum[j] += matrix[i][j];
        }
      }

      // Normalisasi + bobot
      const bobot = matrix.map(row =>
        row.reduce((sum, val, idx) => sum + val / colSum[idx], 0) / n
      );

      // 1. Hapus data bobot lama terlebih dahulu
      db.query('DELETE FROM bobot_kriteria', (deleteErr) => {
        if (deleteErr) return res.status(500).json(deleteErr);

        // 2. Siapkan query untuk insert data bobot baru
        const insertValues = bobot.map((bobotValue, index) => {
          const id_kriteria = kriteria[index].id_kriteria;
          return [id_kriteria, bobotValue.toFixed(4)]; // toFixed(4) sesuai dengan decimal(6,4)
        });

        // 3. Insert data bobot ke tabel bobot_kriteria
        const insertQuery = 'INSERT INTO bobot_kriteria (id_kriteria, bobot) VALUES ?';
        
        db.query(insertQuery, [insertValues], (insertErr, result) => {
          if (insertErr) return res.status(500).json(insertErr);

          // 4. Format response dengan detail bobot per kriteria
          const detailBobot = kriteria.map((k, index) => ({
            id_kriteria: k.id_kriteria,
            nama_kriteria: k.nama_kriteria, // asumsi ada kolom nama_kriteria
            bobot: bobot[index].toFixed(4),
            persentase: (bobot[index] * 100).toFixed(2) + '%'
          }));

          res.json({
            message: 'Bobot kriteria berhasil dihitung dan disimpan',
            total_kriteria: n,
            matrix: matrix,
            bobot: bobot,
            detail_bobot: detailBobot,
            inserted_rows: result.affectedRows
          });
        });
      });
    });
  });
};