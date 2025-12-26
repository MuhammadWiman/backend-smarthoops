const express = require('express');
const router = express.Router();
const perbandingan = require('../controllers/perbandinganController');
const { isPelatih } = require('../middleware/authMiddleware');
const { verifyToken } = require('../middleware/authMiddleware');


router.post('/', verifyToken, isPelatih, perbandingan.inputPerbandingan);

module.exports = router;
