const express = require('express');
const cors = require('cors');
const app = express();
require('dotenv').config();

// Konfigurasi CORS [cite: 13-15]
app.use(cors({
  origin: 'http://localhost:3000', 
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  credentials: true 
}));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Definisi Routes
app.use('/api/auth', require('./routes/authRoutes'));
app.use('/api/pemain', require('./routes/pemainRoutes'));
app.use('/api/kriteria', require('./routes/kriteriaRoutes'));
app.use('/api/perbandingan', require('./routes/perbandinganRoutes'));
app.use('/api/ahp', require('./routes/ahpRoutes'));
app.use('/api/penilaian', require('./routes/penilaianRoutes'));

/** * PENAMBAHAN: Route khusus Ranking 
 * Memisahkan Ranking agar sesuai dengan poin 8 pada Prototype.
 */
app.use('/api/ranking', require('./routes/ahpRoutes')); 

module.exports = app;