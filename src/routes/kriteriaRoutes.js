const express = require('express');
const router = express.Router();
const kriteria = require('../controllers/kriteriaController');
const auth = require('../middleware/authMiddleware');

router.get('/', auth, kriteria.getAll);
router.post('/', auth, kriteria.create);
router.put('/:id', auth, kriteria.update);
router.delete('/:id', auth, kriteria.delete);

module.exports = router;
