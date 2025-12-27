const express = require('express');
const router = express.Router();
const penilaian = require('../controllers/penilaianController');
const auth = require('../middleware/authMiddleware');

// 1. Endpoint untuk mendapatkan status penilaian (Selesai/Proses) per pemain
// Diakses oleh Admin & Pelatih untuk memantau progres
router.get('/status', auth.verifyToken, penilaian.getStatusPenilaian);

// 2. Input nilai oleh pelatih (bulk insert/update)
// Dibatasi hanya untuk role Pelatih
router.post('/', auth.verifyToken, auth.isPelatih, penilaian.simpanPenilaian);

// 3. Mengambil rata-rata penilaian dari SEMUA pelatih
// Digunakan untuk kalkulasi Ranking Final
router.get('/', auth.verifyToken, penilaian.getAllPenilaianAggregated);

// 4. Mengambil penilaian spesifik satu pemain oleh pelatih tertentu
// Digunakan saat pelatih ingin mengedit nilai yang sudah ada
router.get('/:id_pemain/:id_user', auth.verifyToken, auth.isPelatih, penilaian.getPenilaianByPelatih);

module.exports = router;