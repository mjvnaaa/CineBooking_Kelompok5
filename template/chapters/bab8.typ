= Penutup dan Pengujian

Berdasarkan hasil pengujian yang telah dilakukan sesuai dengan skenario yang ditetapkan, dapat disimpulkan bahwa aplikasi CineBooking telah memenuhi seluruh kriteria fungsional dan logika bisnis yang diwajibkan.

== Pengujian Trap Judul
Pada pengujian Trap Judul, pemilihan film dengan judul pendek “Avengers” (8 karakter) dan judul panjang “Spider-Man: No Way Home” (21 karakter) menunjukkan perbedaan harga tiket. Film dengan judul lebih dari 10 karakter dikenakan tambahan Long Title Tax, sehingga harga dasar per kursi meningkat sesuai ketentuan. Hal ini membuktikan bahwa logika penambahan pajak berdasarkan panjang judul film telah diimplementasikan dengan benar.

== Pengujian Trap kursi
Pada pengujian Trap Kursi, pemilihan kursi A1 (ganjil) dan A2 (genap) menghasilkan total harga yang tidak dihitung secara linear. Kursi ganjil dikenakan harga normal, sedangkan kursi genap mendapatkan diskon sebesar 10%, sehingga total harga sesuai dengan rumus HargaDasar + (HargaDasar – 10%). Hasil ini memastikan bahwa aturan Odd/Even Seat Rule diterapkan secara manual dan akurat.

== Pengujian Crash Handling
Pada pengujian Crash Handling, ketika koneksi internet dimatikan saat tombol “Bayar” ditekan, aplikasi tidak mengalami force close. Sistem menampilkan pesan kesalahan kepada pengguna melalui notifikasi, sehingga pengguna tetap berada di dalam aplikasi. Hal ini menunjukkan bahwa mekanisme error handling telah berjalan dengan baik dan aplikasi memiliki stabilitas yang memadai.

== Video Demo Kode
#show link: underline
https://drive.google.com/drive/folders/1QkQTW50Yjv8zw_441B2LT8Kr62dnattT?usp=sharing