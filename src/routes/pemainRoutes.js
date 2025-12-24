const express = require('express');
const router = express.Router();
const pemain = require('../controllers/pemainController');
const auth = require('../middleware/authMiddleware');

router.get('/', auth, pemain.getAll);
router.post('/', auth, pemain.create);
router.put('/:id', auth, pemain.update);
router.delete('/:id', auth, pemain.delete);

module.exports = router;
