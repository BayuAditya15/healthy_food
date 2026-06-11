# 🍎 BuahSehat — Aplikasi E-Commerce Buah Segar

**BuahSehat** adalah aplikasi e-commerce mobile berbasis Flutter untuk pembelian buah segar secara online, dilengkapi dengan backend Laravel + REST API dan dashboard admin menggunakan Filament.

---

## 📋 Daftar Isi

- [Fitur User (Mobile)](#fitur-user-mobile)
- [Fitur Admin (Dashboard)](#fitur-admin-dashboard)
- [Teknologi yang Digunakan](#teknologi-yang-digunakan)
- [Struktur Folder Frontend](#struktur-folder-frontend-flutter)
- [Struktur Folder Backend](#struktur-folder-backend-laravel)
- [Database Schema](#database-schema)
- [API Endpoint](#api-endpoint)
- [Instalasi Backend](#instalasi-backend)
- [Instalasi Frontend](#instalasi-frontend)
- [Menjalankan Project](#menjalankan-project)
- [Akses Dashboard Admin Filament](#akses-dashboard-admin-filament)
- [Screenshots](#screenshots)
- [Kontributor](#kontributor)

---

## Fitur User (Mobile)

| Fitur | Keterangan |
|---|---|
| **Register & Login** | Registrasi akun baru dan login menggunakan email + password via Laravel Sanctum |
| **Lupa Password** | Halaman lupa password (forget password page) |
| **Browsing Produk** | Melihat daftar semua produk buah beserta gambar, harga, stok, dan deskripsi |
| **Kategori Produk** | Memfilter produk berdasarkan kategori |
| **Detail Produk** | Halaman detail produk dengan deskripsi lengkap dan pilihan quantity |
| **Keranjang Belanja** | Menambah, mengubah quantity, dan menghapus item di keranjang (disimpan lokal via `shared_preferences`) |
| **Wishlist** | Menyimpan produk favorit secara lokal (toggle add/remove) |
| **Checkout** | Form pengisian data pengiriman (nama, email, telepon, kota, kode pos, negara) dan pilihan metode pembayaran |
| **Pemilihan Metode Pembayaran** | Mendukung Cash on Delivery dan input detail pembayaran lainnya |
| **Buat Order** | Mengirim order ke backend, stok produk otomatis berkurang |
| **Review Produk** | Memberikan rating (1–5 bintang) dan komentar untuk produk yang dibeli |
| **Melihat Review** | Membaca ulasan pengguna lain pada halaman detail produk |
| **Profil User** | Melihat data profil (nama, email) yang disinkronkan dari API |
| **Logout** | Menghapus sesi token dari server dan lokal |
| **Dark Mode & Tema Warna** | Mendukung light/dark mode dan kustomisasi warna primer |
| **Landing Page** | Halaman pembuka sebelum masuk ke login/register |

---

## Fitur Admin (Dashboard)

Dashboard admin dibangun menggunakan **Filament v5** dan dapat diakses melalui browser.

| Fitur | Keterangan |
|---|---|
| **Login Admin** | Autentikasi admin menggunakan akun User Laravel |
| **Dashboard Statistik** | Widget statistik menampilkan total Produk, total Kategori, jumlah Stok Kritis (stok ≤ 10), dan total Order |
| **Manajemen Produk** | CRUD produk: tambah, lihat daftar, edit, dan hapus (dengan upload gambar) |
| **Manajemen Kategori** | CRUD kategori produk |
| **Manajemen Order** | Melihat daftar order masuk, mengedit status pesanan |
| **Stok Kritis** | Filter cepat menampilkan produk dengan stok ≤ 10 dari widget dashboard |

---

## Teknologi yang Digunakan

### Frontend (Mobile)
| Teknologi | Versi | Keterangan |
|---|---|---|
| Flutter | SDK ^3.11.0 | Framework mobile cross-platform |
| Dart | ^3.11.0 | Bahasa pemrograman |
| `http` | ^1.6.0 | HTTP client untuk konsumsi REST API |
| `shared_preferences` | ^2.5.5 | Penyimpanan lokal (cart, wishlist, token, profil) |
| `google_fonts` | ^8.0.2 | Kustomisasi tipografi |
| `cupertino_icons` | ^1.0.8 | Ikon style iOS |

### Backend (API)
| Teknologi | Versi | Keterangan |
|---|---|---|
| PHP | ^8.3 | Bahasa pemrograman backend |
| Laravel | ^13.8 | Framework PHP |
| Laravel Sanctum | ^4.3 | Autentikasi API berbasis token |
| Filament | ^5.6 | Admin panel (CRUD + dashboard) |
| MySQL | — | Database (nama DB: `healthy_fruits`) |

---

## Struktur Folder Frontend (Flutter)

```
buahsehat/
├── lib/
│   ├── main.dart                  # Entry point, setup tema & routing awal
│   ├── themes/
│   │   ├── app_theme.dart         # Definisi light & dark theme
│   │   └── theme_controller.dart  # ValueNotifier untuk dark mode & primary color
│   ├── models/
│   │   ├── category_model.dart    # Model data kategori
│   │   ├── product_model.dart     # Model data produk
│   │   ├── cart_item_model.dart   # Model item keranjang
│   │   ├── wishlist_item_model.dart # Model item wishlist
│   │   └── review_model.dart      # Model data review
│   ├── services/
│   │   ├── category_service.dart  # Fetch kategori dari API
│   │   ├── product_service.dart   # Fetch produk dari API
│   │   ├── cart_service.dart      # Manajemen keranjang lokal (SharedPreferences)
│   │   ├── wishlist_service.dart  # Manajemen wishlist lokal (SharedPreferences)
│   │   ├── user_profile_service.dart # Fetch profil user & logout
│   │   └── review_service.dart    # Fetch & kirim review ke API
│   ├── pages/
│   │   ├── auth/
│   │   │   ├── landing_page.dart        # Halaman pembuka
│   │   │   ├── Login_page.dart          # Login
│   │   │   ├── register_page.dart       # Register
│   │   │   └── forget_password_page.dart # Lupa password
│   │   ├── home/
│   │   │   └── home_page.dart           # Beranda utama
│   │   ├── category/
│   │   │   ├── categories_page.dart     # Daftar semua kategori
│   │   │   └── category_page.dart       # Produk per kategori
│   │   ├── product/
│   │   │   └── product_detail_page.dart # Detail produk + review
│   │   ├── cart/
│   │   │   └── cart_page.dart           # Keranjang belanja
│   │   ├── wishlist/
│   │   │   └── wishlist_page.dart       # Daftar wishlist
│   │   ├── checkout/
│   │   │   ├── checkout_page.dart       # Form checkout & pembayaran
│   │   │   └── review_page.dart         # Konfirmasi order sebelum submit
│   │   ├── profile/
│   │   │   ├── profile_page.dart        # Halaman profil user
│   │   │   ├── profile_detail_page.dart # Detail info profil
│   │   │   └── color_skins_page.dart    # Kustomisasi tema warna
│   │   ├── review/
│   │   │   └── write_review_page.dart   # Tulis ulasan produk
│   │   ├── payment/
│   │   │   └── payment_page.dart        # Halaman pembayaran
│   │   ├── notification/
│   │   │   └── notification_page.dart   # Halaman notifikasi
│   │   └── message/
│   │       ├── messages_page.dart       # Daftar pesan
│   │       └── chat_detail_page.dart    # Detail chat
│   └── widgets/
│       ├── bottom_nav.dart          # Bottom navigation bar
│       ├── header.dart              # App bar / header
│       ├── product_card.dart        # Kartu produk (grid)
│       ├── product_item.dart        # Item produk (list)
│       ├── category.dart            # Widget kategori
│       ├── trending.dart            # Seksi produk trending
│       ├── banner.dart              # Banner promosi
│       ├── review_item.dart         # Item review
│       ├── rating_section.dart      # Seksi rating bintang
│       ├── quantity_selector.dart   # Selector jumlah produk
│       └── profile_menu_item.dart   # Item menu profil
├── assets/
│   └── images/                    # Aset gambar lokal
└── pubspec.yaml
```

---

## Struktur Folder Backend (Laravel)

```
buahsehat-api/
├── app/
│   ├── Models/
│   │   ├── User.php          # Model user (auth + Sanctum)
│   │   ├── Category.php      # Model kategori
│   │   ├── Product.php       # Model produk (belongsTo category, hasMany reviews)
│   │   ├── Order.php         # Model order (hasMany orderItems)
│   │   ├── OrderItem.php     # Model item order
│   │   ├── Review.php        # Model review (belongsTo product & user)
│   │   ├── Cart.php          # Model cart
│   │   └── Wishlist.php      # Model wishlist
│   ├── Http/Controllers/Api/
│   │   ├── AuthController.php      # register, login, logout, profile
│   │   ├── ProductController.php   # index (daftar produk + URL gambar)
│   │   ├── CategoryController.php  # index, byCategory
│   │   ├── OrderController.php     # store (buat order + kurangi stok, DB transaction)
│   │   └── ReviewController.php    # store, byProduct
│   ├── Filament/
│   │   ├── Resources/
│   │   │   ├── Products/ProductResource.php    # CRUD produk
│   │   │   ├── Categories/CategoryResource.php # CRUD kategori
│   │   │   └── Orders/OrderResource.php        # Manajemen order
│   │   └── Widgets/
│   │       ├── StatsOverview.php   # Widget statistik dashboard
│   │       └── OrderChart.php      # Widget chart order
│   └── Providers/
│       └── Filament/AdminPanelProvider.php   # Konfigurasi panel admin
├── database/
│   ├── migrations/           # Semua file migrasi tabel
│   └── seeders/
│       └── DatabaseSeeder.php  # Seed user default
├── routes/
│   ├── api.php               # Semua API endpoint
│   └── web.php               # Route web (Filament)
└── composer.json
```

---

## Database Schema

Database: **`healthy_fruits`** (MySQL)

### Tabel `users`
| Kolom | Tipe | Keterangan |
|---|---|---|
| id | bigint PK | Auto increment |
| name | varchar | Nama pengguna |
| email | varchar UNIQUE | Email pengguna |
| email_verified_at | timestamp | Nullable |
| password | varchar | Di-hash bcrypt |
| remember_token | varchar | Nullable |
| timestamps | — | created_at, updated_at |

### Tabel `categories`
| Kolom | Tipe | Keterangan |
|---|---|---|
| id | bigint PK | Auto increment |
| name | varchar | Nama kategori |
| timestamps | — | created_at, updated_at |

### Tabel `products`
| Kolom | Tipe | Keterangan |
|---|---|---|
| id | bigint PK | Auto increment |
| category_id | FK → categories | Cascade delete |
| name | varchar | Nama produk |
| description | text | Deskripsi produk |
| price | decimal(12,2) | Harga produk |
| stock | integer | Jumlah stok |
| image | varchar | Path file gambar (nullable) |
| timestamps | — | created_at, updated_at |

### Tabel `orders`
| Kolom | Tipe | Keterangan |
|---|---|---|
| id | bigint PK | Auto increment |
| user_id | FK → users | Cascade delete |
| total_price | decimal(12,2) | Total harga order |
| status | enum | `pending`, `processing`, `completed`, `cancelled` |
| shipping_name | varchar | Nama penerima |
| shipping_email | varchar | Email penerima |
| shipping_phone | varchar | Telepon penerima |
| shipping_zip | varchar | Kode pos (nullable) |
| shipping_city | varchar | Kota (nullable) |
| shipping_country | varchar | Negara (nullable) |
| payment_method | varchar | Metode pembayaran (nullable) |
| payment_details | varchar | Detail pembayaran (nullable) |
| timestamps | — | created_at, updated_at |

### Tabel `order_items`
| Kolom | Tipe | Keterangan |
|---|---|---|
| id | bigint PK | Auto increment |
| order_id | FK → orders | Cascade delete |
| product_id | FK → products | Cascade delete |
| quantity | integer | Jumlah item |
| price | decimal(12,2) | Harga saat order dibuat |
| timestamps | — | created_at, updated_at |

### Tabel `reviews`
| Kolom | Tipe | Keterangan |
|---|---|---|
| id | bigint PK | Auto increment |
| user_id | FK → users | Cascade delete |
| product_id | FK → products | Cascade delete |
| rating | integer | Rating 1–5 |
| comment | text | Komentar review |
| timestamps | — | created_at, updated_at |

### Tabel `carts` & `wishlists`
> Didefinisikan di model backend, namun manajemen cart dan wishlist dilakukan secara lokal di Flutter menggunakan `shared_preferences`.

---

## API Endpoint

Base URL: `http://127.0.0.1:8000/api`

### Public (Tanpa Auth)
| Method | Endpoint | Keterangan |
|---|---|---|
| POST | `/register` | Registrasi user baru |
| POST | `/login` | Login, mengembalikan Sanctum token |
| GET | `/products` | Daftar semua produk beserta kategori & URL gambar |
| GET | `/categories` | Daftar semua kategori |
| GET | `/categories/{id}/products` | Produk berdasarkan kategori |
| GET | `/products/{id}/reviews` | Daftar review berdasarkan produk |

### Protected (Memerlukan `Authorization: Bearer <token>`)
| Method | Endpoint | Keterangan |
|---|---|---|
| GET | `/profile` | Data profil user yang sedang login |
| POST | `/logout` | Invalidasi token saat ini |
| POST | `/orders` | Buat order baru (validasi stok, DB transaction) |
| GET | `/orders` | Daftar order milik user |
| GET | `/orders/{id}` | Detail order |
| PUT | `/orders/{id}` | Update order |
| DELETE | `/orders/{id}` | Hapus order |
| POST | `/reviews` | Kirim review produk |

---

## Instalasi Backend

**Prasyarat:** PHP 8.3+, Composer, MySQL

```bash
# 1. Masuk ke folder backend
cd buahsehat-api

# 2. Install dependensi PHP
composer install

# 3. Salin file environment
cp .env.example .env

# 4. Generate application key
php artisan key:generate

# 5. Konfigurasi database di .env
#    DB_DATABASE=healthy_fruits
#    DB_USERNAME=root
#    DB_PASSWORD=

# 6. Buat database MySQL
mysql -u root -e "CREATE DATABASE healthy_fruits;"

# 7. Jalankan migrasi
php artisan migrate

# 8. (Opsional) Seed user default
php artisan db:seed

# 9. Buat symlink untuk storage gambar
php artisan storage:link

# 10. Build asset Filament
npm install && npm run build
```

---

## Instalasi Frontend

**Prasyarat:** Flutter SDK ^3.11.0, Dart ^3.11.0

```bash
# 1. Masuk ke folder frontend
cd buahsehat

# 2. Install dependensi Flutter
flutter pub get
```

> **Konfigurasi Base URL:** Pastikan base URL di semua service Flutter sudah sesuai dengan alamat server backend:
> - `lib/services/user_profile_service.dart` → `http://127.0.0.1:8000/api`
> - `lib/services/review_service.dart` → `http://127.0.0.1:8000/api`
> - `lib/pages/auth/Login_page.dart` → `http://127.0.0.1:8000/api/login`
> - `lib/pages/checkout/checkout_page.dart` → `http://127.0.0.1:8000/api`
>
> Jika menggunakan emulator Android, ganti `127.0.0.1` dengan `10.0.2.2`.

---

## Menjalankan Project

### Backend
```bash
cd buahsehat-api
php artisan serve
# Server berjalan di: http://127.0.0.1:8000
```

### Frontend
```bash
cd buahsehat
flutter run
```

---

## Akses Dashboard Admin Filament

1. Pastikan backend sudah berjalan (`php artisan serve`)
2. Buka browser dan akses: **http://127.0.0.1:8000/admin**
3. Login menggunakan akun User yang ada di database
4. Untuk membuat akun admin, gunakan perintah:
   ```bash
   php artisan make:filament-user
   ```

**Fitur yang tersedia di dashboard:**
- **Dashboard** — Statistik total produk, kategori, stok kritis, dan order
- **Products** — CRUD produk dengan upload gambar
- **Categories** — CRUD kategori
- **Orders** — Melihat dan mengelola status pesanan

---

## Screenshots

> Tambahkan screenshot aplikasi di sini.

| Landing Page | Home | Produk Detail |
|---|---|---|
| <img width="304" height="640" alt="Screenshot 2026-06-09 182233" src="https://github.com/user-attachments/assets/2953dc1e-2019-46be-9c75-0a6d7525e8ed" />
 | <img width="295" height="640" alt="Screenshot 2026-06-09 182527" src="https://github.com/user-attachments/assets/88fd81c4-b42d-4601-97e7-e9cf6aedab98" />
 | <img width="300" height="645" alt="Screenshot 2026-06-09 182837" src="https://github.com/user-attachments/assets/afd1617c-0c75-45f2-9fa9-e00ea5a8c48a" />
 |

| Category | Wishlist | Profil |
|---|---|---|
| <img width="295" height="636" alt="Screenshot 2026-06-09 182734" src="https://github.com/user-attachments/assets/d5ff867d-056c-4bc1-8f1d-57b38e77885c" />
 | <img width="298" height="634" alt="Screenshot 2026-06-09 182922" src="https://github.com/user-attachments/assets/54c8f4ef-6e39-44b5-b14d-61e3da6a837a" />
 | <img width="306" height="642" alt="Screenshot 2026-06-09 183329" src="https://github.com/user-attachments/assets/4dde0990-665b-4527-b973-e118dbd3d164" />
 |

| Keranjang | Checkout | Dashboard Admin |
|---|---|---|
| <img width="300" height="637" alt="Screenshot 2026-06-09 182948" src="https://github.com/user-attachments/assets/0748a97c-e70c-464e-95bc-38c6f7cc6921" />
 | <img width="301" height="640" alt="Screenshot 2026-06-09 183053" src="https://github.com/user-attachments/assets/82715486-baef-447c-849b-829adf95da75" />
 | <img width="1917" height="874" alt="Screenshot 2026-06-09 184007" src="https://github.com/user-attachments/assets/be0c9d8a-bea8-424b-83e3-385c79a892ad" />
 |

---

## Kontributor

| NPM | Nama |
|---|---|
| 5230311003| Rahmad Dhanu Widi Anggoro |
| 5230311016| Sena Nugraha |
| 5230311042| Agis Maulana |
| 5230311047| Bayu Dwi Aditya Saputra |
| 5230311055| Muhammad Fadhil Allamsyah |

---

> Project ini dibuat sebagai aplikasi e-commerce buah segar dengan arsitektur **Flutter (mobile) + Laravel REST API + Filament Admin Panel**.
