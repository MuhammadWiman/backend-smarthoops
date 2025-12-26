const express = require('express');
const router = express.Router();
const kriteria = require('../controllers/kriteriaController');
const auth = require('../middleware/authMiddleware');

router.get('/', auth.verifyToken,  kriteria.getAll);
router.post('/', auth.verifyToken, kriteria.create);
router.put('/:id', auth.verifyToken, kriteria.update);
router.delete('/:id', auth.verifyToken,  kriteria.delete);

module.exports = router;
