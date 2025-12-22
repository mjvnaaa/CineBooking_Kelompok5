= Implementasi Halaman Home

== Implementasi Halaman Home
Halaman Home merupakan halaman utama pada aplikasi CineBooking yang menampilkan daftar film yang sedang tersedia. Halaman ini menjadi titik awal interaksi pengguna setelah berhasil login.  
Tampilan halaman Home dibuat menggunakan widget `Scaffold` yang terdiri dari `AppBar` dan bagian body utama.

```dart
return Scaffold(
  backgroundColor: const Color(0xFF0F1419),
  appBar: AppBar(
    backgroundColor: const Color(0xFF1A1F29),
  ),
```
Pada bagian `AppBar`, ditambahkan ikon profil di sebelah kiri yang mengarahkan pengguna ke halaman profil, serta tombol logout di sebelah kanan. Proses logout dilengkapi dengan dialog konfirmasi agar pengguna tidak keluar aplikasi secara tidak sengaja.

== Penampilan Data Film pada Halaman Home
Daftar film pada halaman Home ditampilkan menggunakan `StreamBuilder` yang terhubung dengan Firebase Firestore.

```dart
StreamBuilder(
  stream: FirebaseFirestore.instance.collection("movies").snapshots(),
  builder: (context, snapshot) { 
    // implementasi builder
  }
)
```
Penggunaan `StreamBuilder` bertujuan agar tampilan film dapat diperbarui secara otomatis ketika terjadi perubahan data pada database, seperti penambahan atau penghapusan film.  
Jika data masih dimuat, aplikasi akan menampilkan indikator loading. Apabila tidak terdapat data film, maka akan ditampilkan pesan "No Movies Available" agar pengguna mengetahui kondisi tersebut.

== Tampilan Daftar Film Menggunakan Grid
Film ditampilkan dalam bentuk grid agar tampilannya lebih rapi dan mudah dilihat. Implementasi grid dilakukan menggunakan `GridView.builder`.

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: gridCount,
  ),
  itemBuilder: (context, i) {
    return MovieCardAdel(movie: movies[i], onTap: () {});
  },
)
```
Jumlah kolom grid disesuaikan dengan ukuran layar menggunakan `MediaQuery`.  
Jika layar berukuran besar, jumlah kolom akan bertambah sehingga tampilan tetap responsif di berbagai perangkat.

== Implementasi Komponen Movie Card
Setiap film ditampilkan menggunakan komponen `MovieCardAdel`. Komponen ini menampilkan poster film, judul, rating, harga tiket, dan durasi film.

```dart
InkWell(
  onTap: onTap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
)
```
Widget `InkWell` digunakan agar kartu film dapat ditekan dan memberikan respon visual kepada pengguna. Poster film ditampilkan menggunakan `Image.network` dan dilengkapi dengan error handler jika gambar gagal dimuat.  
Selain itu, ditambahkan efek bayangan (shadow) dan gradasi warna agar tampilan kartu film terlihat lebih menarik dan modern.

== Halaman Detail Film
Halaman detail film digunakan untuk menampilkan informasi lengkap dari film yang dipilih. Tampilan halaman ini dibuat menggunakan `CustomScrollView` dan `SliverAppBar`.

```dart
SliverAppBar(
  expandedHeight: 450,
  pinned: true,
  flexibleSpace: FlexibleSpaceBar(
    background: Image.network(movie.poster_url),
  ),
)
```
Penggunaan `SliverAppBar` memberikan efek animasi saat halaman di-scroll, sehingga tampilan terlihat lebih dinamis.  
Transisi antar halaman juga menggunakan `Hero` agar perpindahan dari poster film ke halaman detail terlihat lebih halus.  
Informasi film seperti judul, rating, durasi, dan harga tiket ditampilkan dalam bentuk kartu informasi agar mudah dibaca oleh pengguna.

== Navigasi ke Halaman Pemilihan Kursi
Pada bagian bawah halaman detail film terdapat tombol `Select Seats` yang digunakan untuk melanjutkan proses pemesanan tiket.

```dart
FloatingActionButton.extended(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SeatPageIntan(
          movieTitleIntan: movie.title,
          basePriceIntan: movie.base_price,
        ),
      ),
    );
  },
)
```
Tombol ini memudahkan pengguna untuk langsung menuju halaman pemilihan kursi setelah melihat detail film yang diinginkan.

== Kesimpulan
Berdasarkan implementasi yang telah dilakukan, antarmuka pengguna pada aplikasi CineBooking telah dirancang dengan tampilan yang sederhana, responsif, dan mudah digunakan.  
Setiap halaman saling terhubung dengan baik melalui navigasi yang jelas, sehingga pengguna dapat melakukan proses pemesanan tiket dengan nyaman.  
Pengelolaan data dan logika aplikasi ditangani pada modul lain, sedangkan pada bab ini difokuskan pada implementasi tampilan dan interaksi pengguna.
