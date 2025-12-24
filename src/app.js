const express = require('express');
const app = express();
require('dotenv').config();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/api/auth', require('./routes/authRoutes'));
app.use('/api/pemain', require('./routes/pemainRoutes'));
app.use('/api/kriteria', require('./routes/kriteriaRoutes'));
app.use('/api/perbandingan', require('./routes/perbandinganRoutes'));
app.use('/api/ahp', require('./routes/ahpRoutes'));
app.use('/api/penilaian', require('./routes/penilaianRoutes'));

module.exports = app;
