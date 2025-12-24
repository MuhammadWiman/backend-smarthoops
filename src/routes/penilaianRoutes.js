const express = require('express');
const router = express.Router();
const penilaian = require('../controllers/penilaianController');

// Input nilai (bulk)
router.post('/', penilaian.simpanPenilaian);

// Semua penilaian
router.get('/', penilaian.getAllPenilaian);

// Penilaian per pemain
router.get('/:id_pemain', penilaian.getPenilaianByPemain);

module.exports = router;
