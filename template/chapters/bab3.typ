= Arsitektur Backend
Dikerjakan oleh Backend Architect:

== Struktur Database (Firestore)
Database menggunakan Cloud Firestore dengan 3 Collection utama. Penamaan field (`snake_case`) disesuaikan untuk fungsi `toMapJevon` dan `fromMapJevon`.

== Collection: users
Menyimpan data profil pengguna dan saldo.
1. uid (String): Primary Key (dari Firebase Auth)
2. email (String): Email mahasiswa
3. username (String): Nama tampilan pengguna
4. balance (Number (Int)): Saldo awal (Default: 0)
5. created_at (Timestamp): Waktu registrasi akun

== Collection: movies
Menyimpan data film untuk ditampilkan pada Grid Home.
1. movie_id (String): Primary Key (Manual ID: movie1 - movie10)
2. title (String): Judul Film (Logic Trap Title Tax)
3. poster_url (String): URL Gambar Poster (TMDB)
4. base_price (Number (Int)): Harga dasar tiket
5. rating (Number (Double)): Rating film (1.0 - 5.0)
6. duration (Number (Int)): Durasi film dalam menit

== Collection: bookings
Menyimpan riwayat transaksi tiket.
1. booking_id (String): Primary Key (Auto Generated UUID)
2. user_id (String): Foreign Key ke collection Users
3. movie_title (String): Disimpan statis untuk riwayat
4. seats (Array (String)): List kursi (Contoh: ["A1", "A2"])
5. total_price (Number (Int)): Harga final setelah Logic Trap
6. booking_date (Timestamp): Waktu transaksi dilakukan


== Implementasi Class Model (Protokol Integritas)
Semua Model Data dibuat manual dengan akhiran Jevon.

User: UserModelJevon (File: user_model_jevon.dart)  
Movie: MovieModelJevon (File: movie_model_jevon.dart)  
Booking: BookingModelJevon (File: booking_model_jevon.dart)  

Setiap class memiliki fungsi `fromMapJevon` dan `toMapJevon`.

== Data Seeding
Proses *seeding* dilakukan melalui class MovieSeederJevon di halaman SeedPageJevon.  
Data dummy mencakup variasi panjang judul untuk *Logic Trap* ("The Long Title Tax").

Daftar 10 Produk Dummy (Film):
1. Avatar (Judul Pendek - 6 huruf)
2. Titanic (Judul Pendek - 7 huruf)
3. Spider-Man: No Way Home (Judul Panjang > 10 huruf - Kena Pajak)
4. The Batman (Judul Pas 10 huruf) 
5. Avengers: Endgame (Judul Panjang - Kena Pajak)
6. Dune (Judul Pendek)
7. No Time To Die (Judul Panjang - Kena Pajak)
8. The Matrix Resurrections (Judul Panjang - Kena Pajak)
9. Eternals (Judul Pendek)
10. Shang-Chi (Judul Pendek)