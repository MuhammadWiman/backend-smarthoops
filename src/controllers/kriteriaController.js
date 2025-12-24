const db = require('../config/db');

exports.getAll = (req, res) => {
  db.query('SELECT * FROM kriteria', (err, result) => {
    res.json(result);
  });
};

exports.create = (req, res) => {
  const { nama_kriteria, kelompok } = req.body;
  db.query(
    'INSERT INTO kriteria (nama_kriteria, kelompok) VALUES (?,?)',
    [nama_kriteria, kelompok],
    () => res.json({ message: 'Kriteria ditambahkan' })
  );
};

exports.update = (req, res) => {
  db.query(
    'UPDATE kriteria SET ? WHERE id_kriteria=?',
    [req.body, req.params.id],
    () => res.json({ message: 'Kriteria diupdate' })
  );
};

exports.delete = (req, res) => {
  db.query(
    'DELETE FROM kriteria WHERE id_kriteria=?',
    [req.params.id],
    () => res.json({ message: 'Kriteria dihapus' })
  );
};
