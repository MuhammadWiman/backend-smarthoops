# SmartHoops - Backend API

SmartHoops adalah sistem pendukung keputusan (SPK) untuk seleksi atlet basket menggunakan metode **Analytic Hierarchy Process (AHP)**. Backend ini dirancang untuk mendukung fitur **Multi-Evaluator**, di mana hasil keputusan akhir merupakan konsensus dari penilaian beberapa pelatih sekaligus.

---

##  Fitur Utama

* **Autentikasi & RBAC**: Sistem login dengan *Role-Based Access Control* (Admin & Pelatih).
* **Manajemen Atlet**: CRUD data pemain lengkap dengan atribut fisik dan skill.
* **Manajemen Kriteria**: Pengelolaan 12 kriteria penilaian basket.
* **Multi-Evaluator AHP**:
    * Penyimpanan massal (*Bulk Insert*) 144 baris perbandingan per pelatih.
    * Agregasi penilaian antar pelatih menggunakan **Geometric Mean**.
    * Perhitungan otomatis *Eigenvector* untuk mendapatkan bobot kriteria final.
* **Ranking**: Perangkingan otomatis pemain berdasarkan bobot konsensus.

---

##  Instalasi & Persiapan

### 1. Prasyarat
* Node.js (v20+)
* MySQL / MariaDB

### 2. Cloning project
```bash
git clone https://github.com/MuhammadWiman/backend-smarthoops.git
cd backend-smarthoops
```
---

##  Persiapan Database 

Repositori ini menyertakan file SQL untuk mempermudah pengaturan database Anda di folder `/database`.

### Langkah-langkah:

1. Buat database baru bernama `spk_ahp_basket`.
2. **Import Struktur**: Jalankan/import file `database/schema.sql` untuk membuat semua tabel dan relasi *Foreign Key*.

> **Catatan**: Pastikan relasi `ON DELETE CASCADE` aktif untuk menjaga integritas data saat ada penghapusan user atau kriteria.

---

### 3. Instalasi Dependensi
```bash
npm install
```
### 4. Menjalankan project
```bash
npm run dev
```
