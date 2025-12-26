const db = require('../config/db');
require('dotenv').config();
const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

// 1. REGISTER: Sekarang menyimpan 'role' [cite: 16]
exports.register = async (req, res) => {
  const { nama_lengkap, email, password, role } = req.body;

  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    const userRole = role || 'pelatih'; // Default sebagai pelatih jika tidak diisi [cite: 6]

    db.query(
      'INSERT INTO users (nama_lengkap, email, password, role) VALUES (?, ?, ?, ?)',
      [nama_lengkap, email, hashedPassword, userRole],
      (err) => {
        if (err) return res.status(500).json({ message: 'Email sudah terdaftar atau error database' });
        res.json({ success: true, message: 'User berhasil didaftarkan sebagai ' + userRole });
      }
    );
  } catch (err) {
    res.status(500).json(err);
  }
};

// 2. LOGIN: Mengembalikan id_user dan role untuk Frontend [cite: 16-18]
exports.login = (req, res) => {
  const { email, password } = req.body;

  db.query('SELECT * FROM users WHERE email = ?', [email], async (err, results) => {
    if (err) return res.status(500).json(err);
    if (results.length === 0) return res.status(404).json({ message: 'User tidak ditemukan' });

    const user = results[0];
    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) return res.status(401).json({ message: 'Password salah' });

    // Sertakan id_user dan role ke dalam token JWT
    const token = jwt.sign(
      { id_user: user.id_user, role: user.role }, 
      process.env.JWT_SECRET,  // Memanggil dari .env
      { expiresIn: process.env.JWT_EXPIRES_IN || '1d' }
    );

    res.json({
      success: true,
      token,
      user: {
        id_user: user.id_user,
        nama_lengkap: user.nama_lengkap,
        email: user.email,
        role: user.role // Frontend akan menggunakan ini untuk proteksi halaman [cite: 6]
      }
    });
  });
};