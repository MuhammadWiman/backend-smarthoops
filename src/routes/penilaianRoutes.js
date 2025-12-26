const express = require('express');
const router = express.Router();
const penilaian = require('../controllers/penilaianController');
const auth = require('../middleware/authMiddleware')

// Input nilai (bulk)
router.post('/', auth.verifyToken, auth.isPelatih, penilaian.simpanPenilaian);

// Semua penilaian
router.get('/', auth.verifyToken, auth.isPelatih, penilaian.getAllPenilaianAggregated);

// Penilaian per pemain
router.get('/:id_pemain/:id_user', auth.verifyToken, auth.isPelatih, penilaian.getPenilaianByPelatih);

module.exports = router;
