const express = require('express');
const router = express.Router();
const pemain = require('../controllers/pemainController');
const auth = require('../middleware/authMiddleware');

router.get('/', auth.verifyToken,  pemain.getAll);
router.post('/', auth.verifyToken,  pemain.create);
router.put('/:id', auth.verifyToken,  pemain.update);
router.delete('/:id', auth.verifyToken, pemain.delete);

module.exports = router;
