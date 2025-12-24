const express = require('express');
const router = express.Router();
const perbandingan = require('../controllers/perbandinganController');

router.post('/', perbandingan.inputPerbandingan);

module.exports = router;
