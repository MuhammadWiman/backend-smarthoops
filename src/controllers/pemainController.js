const db = require('../config/db');

exports.getAll = (req, res) => {
  db.query('SELECT * FROM pemain', (err, result) => {
    res.json(result);
  });
};

exports.create = (req, res) => {
  const data = req.body;
  db.query('INSERT INTO pemain SET ?', data, () => {
    res.json({ message: 'Pemain ditambahkan' });
  });
};

exports.update = (req, res) => {
  db.query(
    'UPDATE pemain SET ? WHERE id_pemain=?',
    [req.body, req.params.id],
    () => res.json({ message: 'Pemain diupdate' })
  );
};

exports.delete = (req, res) => {
  db.query(
    'DELETE FROM pemain WHERE id_pemain=?',
    [req.params.id],
    () => res.json({ message: 'Pemain dihapus' })
  );
};
