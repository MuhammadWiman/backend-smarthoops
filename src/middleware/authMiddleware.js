const jwt = require('jsonwebtoken');

// 1. Middleware Utama: Verifikasi Token & Identitas User [cite: 13-16]
exports.verifyToken = (req, res, next) => {
  const authHeader = req.headers.authorization;
  if (!authHeader) return res.status(401).json({ message: 'Akses ditolak, token tidak ditemukan' });

  const token = authHeader.split(' ')[1];
  try {
    // Memverifikasi token menggunakan secret key [cite: 16]
    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'secret_key_anda');
    
    // Menyimpan data user (id_user & role) ke objek request [cite: 17-18]
    // Ini krusial agar controller bisa menggunakan req.user.id_user
    req.user = decoded; 
    
    next();
  } catch (err) {
    res.status(401).json({ message: 'Sesi berakhir atau token tidak valid' });
  }
};

// 2. Middleware Tambahan: Proteksi Role Admin [cite: 6, 41-43]
// Gunakan ini untuk rute sensitif seperti Manajemen Kriteria atau Hapus Data
exports.isAdmin = (req, res, next) => {
  if (req.user && req.user.role === 'admin') {
    next();
  } else {
    res.status(403).json({ message: 'Akses terbatas: Hanya Admin yang diizinkan' });
  }
};

// 3. Middleware Tambahan: Proteksi Role Pelatih/Panitia 
exports.isPelatih = (req, res, next) => {
  if (req.user && (req.user.role === 'pelatih' || req.user.role === 'admin')) {
    next();
  } else {
    res.status(403).json({ message: 'Akses terbatas: Hanya Pelatih/Panitia yang diizinkan' });
  }
};