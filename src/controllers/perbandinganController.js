const db = require('../config/db');

exports.inputPerbandingan = (req, res) => {
  // 1. Terima array 'comparisons' dari body
  const { comparisons } = req.body; 

  if (!comparisons || !Array.isArray(comparisons) || comparisons.length === 0) {
    return res.status(400).json({ message: 'Data tidak lengkap atau format salah' });
  }

  // Ambil id_user dari data pertama dalam array
  const id_user = comparisons[0].id_user;

  // 2. Gunakan Transaction atau urutan DELETE -> INSERT
  // Hapus data lama milik pelatih ini agar tidak menumpuk/ganda
  db.query(
    'DELETE FROM perbandingan_kriteria WHERE id_user = ?',
    [id_user],
    (err) => {
      if (err) return res.status(500).json({ message: 'Gagal membersihkan data lama', error: err });

      // 3. Siapkan data untuk Bulk Insert (Format: [[k1, k2, nilai, user], [k1, k2, nilai, user]])
      const values = comparisons.map(item => [
        item.kriteria_1,
        item.kriteria_2,
        item.nilai,
        item.id_user
      ]);

      // 4. Jalankan Bulk Insert (Hanya 1 Query untuk 144 baris)
      const sql = 'INSERT INTO perbandingan_kriteria (kriteria_1, kriteria_2, nilai, id_user) VALUES ?';
      
      db.query(sql, [values], (err) => {
        if (err) {
          console.error(err);
          return res.status(500).json({ message: 'Gagal menyimpan data massal', error: err });
        }
        
        res.json({ 
          message: `Berhasil menyimpan ${comparisons.length} baris perbandingan untuk pelatih ID: ${id_user}` 
        });
      });
    }
  );
};