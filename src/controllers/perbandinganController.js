const db = require('../config/db');

exports.inputPerbandingan = (req, res) => {
  const { kriteria_1, kriteria_2, nilai } = req.body;

  if (!kriteria_1 || !kriteria_2 || !nilai) {
    return res.status(400).json({ message: 'Data tidak lengkap' });
  }

  db.query(
    'INSERT INTO perbandingan_kriteria (kriteria_1, kriteria_2, nilai) VALUES (?,?,?)',
    [kriteria_1, kriteria_2, nilai],
    (err) => {
      if (err) return res.status(500).json(err);
      res.json({ message: 'Perbandingan kriteria disimpan' });
    }
  );
};

