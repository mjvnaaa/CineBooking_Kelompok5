= Pengujian & Penutup

== Skenario Pengujian yang Dilakukan

1. [*Tes Trap Judul Film*]:
   - Film "Avatar" (6 karakter): harga normal
   #image("images/foto.jpg")
   - Film "Spider-Man: No Way Home" (21 karakter): +Rp 2.500 per kursi

2. [*Tes Trap Kursi Genap*]:
   - Kursi A1 (ganjil): harga normal
   - Kursi A2 (genap): diskon 10%

3. [*Tes Error Handling*]:
   - Matikan internet saat checkout: tampil pesan error
   - Login dengan email non-poliwangi: validasi error

== QR Code untuk Ticket History
```dart
// File: models/profile/ticket_history_page_fariz.dart
QrImageView(
  data: ticket.bookingId,
  version: QrVersions.auto,
  size: 120,
  backgroundColor: Colors.white,
)
```

== Link Video Demo
Berikut adalah link video demo aplikasi yang diunggah ke Google Drive/YouTube:
- [*Link:*] [MASUKKAN_LINK_VIDEO_DEMO]
- Durasi: 2 menit penjelasan kode sesuai requirement

== Kesimpulan
Aplikasi CineBooking telah berhasil mengimplementasikan:
1. Arsitektur Firebase yang sesuai spesifikasi
2. UI responsive dengan animasi Hero
3. Logic trap manual tanpa library kalkulasi instan
4. State management dengan Provider
5. Validasi dan error handling yang komprehensif