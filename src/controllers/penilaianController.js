const db = require('../config/db');

/**
 * POST /api/penilaian
 * Body:
 * {
 *   "id_pemain": 1,
 *   "nilai": [
 *     { "id_kriteria": 1, "nilai": 80 },
 *     { "id_kriteria": 2, "nilai": 75 }
 *   ]
 * }
 */
exports.simpanPenilaian = (req, res) => {
  const { id_pemain, nilai } = req.body;

  if (!id_pemain || !Array.isArray(nilai)) {
    return res.status(400).json({ message: 'Format data salah' });
  }

  const queries = [];

  nilai.forEach(n => {
    if (n.nilai < 0 || n.nilai > 100) {
      return res
        .status(400)
        .json({ message: 'Nilai harus 0 - 100' });
    }

    queries.push(
      new Promise((resolve, reject) => {
        db.query(
          `SELECT * FROM penilaian 
           WHERE id_pemain = ? AND id_kriteria = ?`,
          [id_pemain, n.id_kriteria],
          (err, result) => {
            if (err) return reject(err);

            if (result.length > 0) {
              db.query(
                `UPDATE penilaian 
                 SET nilai = ? 
                 WHERE id_pemain = ? AND id_kriteria = ?`,
                [n.nilai, id_pemain, n.id_kriteria],
                err => (err ? reject(err) : resolve())
              );
            } else {
              db.query(
                `INSERT INTO penilaian (id_pemain, id_kriteria, nilai)
                 VALUES (?, ?, ?)`,
                [id_pemain, n.id_kriteria, n.nilai],
                err => (err ? reject(err) : resolve())
              );
            }
          }
        );
      })
    );
  });

  Promise.all(queries)
    .then(() => res.json({ message: 'Penilaian pemain berhasil disimpan' }))
    .catch(err => res.status(500).json(err));
};

/**
 * GET /api/penilaian
 */
exports.getAllPenilaian = (req, res) => {
  db.query(
    `SELECT 
        pm.id_pemain,
        pm.nama_pemain,
        k.id_kriteria,
        k.nama_kriteria,
        p.nilai
     FROM penilaian p
     JOIN pemain pm ON pm.id_pemain = p.id_pemain
     JOIN kriteria k ON k.id_kriteria = p.id_kriteria
     ORDER BY pm.id_pemain, k.id_kriteria`,
    (err, rows) => {
      if (err) return res.status(500).json(err);
      res.json(rows);
    }
  );
};

/**
 * GET /api/penilaian/:id_pemain
 */
exports.getPenilaianByPemain = (req, res) => {
  const { id_pemain } = req.params;

  db.query(
    `SELECT 
        k.id_kriteria,
        k.nama_kriteria,
        p.nilai
     FROM penilaian p
     JOIN kriteria k ON k.id_kriteria = p.id_kriteria
     WHERE p.id_pemain = ?`,
    [id_pemain],
    (err, rows) => {
      if (err) return res.status(500).json(err);
      res.json(rows);
    }
  );
};
