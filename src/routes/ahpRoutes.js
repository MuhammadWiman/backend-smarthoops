const express = require('express');
const router = express.Router();
const ahp = require('../controllers/ahpController');
const ranking = require('../controllers/rankingController');

router.post('/hitung-bobot', ahp.hitungAHP);
router.get('/ranking', ranking.hitungRanking);

module.exports = router;
