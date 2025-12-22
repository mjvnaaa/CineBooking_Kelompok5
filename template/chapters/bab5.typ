= Antarmuka Halaman Home
== Implementasi Halaman Home
Halaman home menjadi titik awal interaksi pengguna setelah login. Tampilan halaman Home dibuat menggunakan widget `Scaffold` yang terdiri dari `A`ppBar` dan bagian body utama.
```dart
return Scaffold(
  backgroundColor: const Color(0xFF0F1419),
  appBar: AppBar(
    backgroundColor: const Color(0xFF1A1F29),
  ),
);
```
Pada bagian `AppBar`, ditambahkan ikon profil di sebelah kiri yang mengarahkan pengguna ke halaman profil, serta tombol logout di sebelah kanan. Proses logout dilengkapi dengan dialog konfirmasi agar pengguna tidak keluar aplikasi secara tidak sengaja.

== Penampilan Data Film pada Halaman Home
Daftar film pada halaman Home ditampilkan menggunakan StreamBuilder yang terhubung dengan Firebase Firestore.