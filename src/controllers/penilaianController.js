const db = require('../config/db');

// 1. Simpan atau Update Penilaian (Per Pelatih)
exports.simpanPenilaian = (req, res) => {
  const { id_user, id_pemain, nilai } = req.body;

  if (!id_user || !id_pemain || !Array.isArray(nilai)) {
    return res.status(400).json({ message: 'Format data salah atau User ID kosong' });
  }

  const queries = [];

  nilai.forEach(n => {
    if (n.nilai < 0 || n.nilai > 100) {
      return res.status(400).json({ message: 'Nilai harus 0 - 100' });
    }

    queries.push(
      new Promise((resolve, reject) => {
        // Cek keberadaan data untuk pelatih, pemain, dan kriteria tertentu
        db.query(
          `SELECT * FROM penilaian 
           WHERE id_pemain = ? AND id_kriteria = ? AND id_user = ?`,
          [id_pemain, n.id_kriteria, id_user],
          (err, result) => {
            if (err) return reject(err);

            if (result.length > 0) {
              // Jika data sudah ada, lakukan UPDATE
              db.query(
                `UPDATE penilaian 
                 SET nilai = ? 
                 WHERE id_pemain = ? AND id_kriteria = ? AND id_user = ?`,
                [n.nilai, id_pemain, n.id_kriteria, id_user],
                err => (err ? reject(err) : resolve())
              );
            } else {
              // Jika data belum ada, lakukan INSERT
              db.query(
                `INSERT INTO penilaian (id_pemain, id_kriteria, id_user, nilai)
                 VALUES (?, ?, ?, ?)`,
                [id_pemain, n.id_kriteria, id_user, n.nilai],
                err => (err ? reject(err) : resolve())
              );
            }
          }
        );
      })
    );
  });

  Promise.all(queries)
    .then(() => res.json({ message: 'Penilaian dari pelatih berhasil disimpan' }))
    .catch(err => res.status(500).json(err));
};

// 2. Ambil Status Penilaian (Selesai/Proses) - Perbaikan kolom nama
exports.getStatusPenilaian = (req, res) => {
  // Menggunakan p.nama AS nama_pemain karena kolom asli di DB adalah 'nama'
  const sql = `
    SELECT 
        p.id_pemain,
        p.nama AS nama_pemain,
        CASE 
            WHEN COUNT(pn.id_penilaian) = (SELECT COUNT(*) FROM users WHERE role = 'pelatih') * 12 
            THEN 'Selesai' 
            ELSE 'Proses' 
        END as status_penilaian
    FROM pemain p
    LEFT JOIN penilaian pn ON p.id_pemain = pn.id_pemain
    GROUP BY p.id_pemain
  `;

  db.query(sql, (err, rows) => {
    if (err) return res.status(500).json({ success: false, error: err });
    res.json(rows);
  });
};

// 3. Ambil rata-rata nilai dari SEMUA pelatih untuk Ranking Final
exports.getAllPenilaianAggregated = (req, res) => {
  db.query(
    `SELECT 
        pm.id_pemain,
        pm.nama as nama_pemain,
        k.id_kriteria,
        k.nama_kriteria,
        AVG(p.nilai) as nilai_rata_rata,
        COUNT(p.id_user) as jumlah_penilai
     FROM penilaian p
     JOIN pemain pm ON pm.id_pemain = p.id_pemain
     JOIN kriteria k ON k.id_kriteria = p.id_kriteria
     GROUP BY pm.id_pemain, k.id_kriteria
     ORDER BY pm.id_pemain, k.id_kriteria`,
    (err, rows) => {
      if (err) return res.status(500).json(err);
      res.json(rows);
    }
  );
};

// 4. Ambil penilaian spesifik pelatih yang login
exports.getPenilaianByPelatih = (req, res) => {
  const { id_pemain, id_user } = req.params;

  db.query(
    `SELECT 
        k.id_kriteria,
        k.nama_kriteria,
        p.nilai
     FROM penilaian p
     JOIN kriteria k ON k.id_kriteria = p.id_kriteria
     WHERE p.id_pemain = ? AND p.id_user = ?`,
    [id_pemain, id_user],
    (err, rows) => {
      if (err) return res.status(500).json(err);
      res.json(rows);
    }
  );
};