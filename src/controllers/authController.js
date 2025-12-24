const db = require('../config/db');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

exports.register = async (req, res) => {
  const { email, password } = req.body;
  const hash = await bcrypt.hash(password, 10);

  db.query(
    'INSERT INTO users (email, password) VALUES (?,?)',
    [email, hash],
    (err) => {
      if (err) return res.status(500).json(err);
      res.json({ message: 'Register berhasil' });
    }
  );
};

exports.login = (req, res) => {
  const { email, password } = req.body;

  db.query(
    'SELECT * FROM users WHERE email=?',
    [email],
    async (err, result) => {
      if (result.length === 0)
        return res.status(401).json({ message: 'User tidak ditemukan' });

      const valid = await bcrypt.compare(password, result[0].password);
      if (!valid)
        return res.status(401).json({ message: 'Password salah' });

      const token = jwt.sign(
        { id: result[0].id_user },
        process.env.JWT_SECRET
      );

      res.json({ token });
    }
  );
};
