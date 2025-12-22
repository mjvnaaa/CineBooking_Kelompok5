= Implementasi Antarmuka & Auth

== Halaman Login & Register (Fariz)
- Validasi email harus menggunakan domain `@poliwangi.ac.id`
- Implementasi `SharedPreferences` untuk remember me
- Error handling dengan snackbar

```dart
// File: models/auth/login_page_fariz.dart
final regexEmail = RegExp(r'^[a-zA-Z0-9._%+-]+@poliwangi\.ac\.id$');
```

== Halaman Home (Adel)
- Menggunakan `GridView.builder` dengan `SliverGridDelegate`
- Hero animation pada poster film
- Responsif untuk berbagai ukuran layar

```dart
// File: models/home/home_page_adel.dart
int gridCount = screenWidth > 600 ? 3 : 2;
```

== Halaman Seat Selection (Intan)
- Grid kursi 6x6 dengan visual state:
  - Abu-abu: Available
  - Biru: Selected
  - Merah: Sold
- Interaksi toggle select/unselect

```dart
// File: modules/seat/seat_item_intan.dart
Color seatColorIntan;
if (isSoldIntan) {
  seatColorIntan = Color(0xFF2D1B1B); // Merah
} else if (isSelectedIntan) {
  seatColorIntan = Color(0xFF1A2634); // Biru
} else {
  seatColorIntan = Color(0xFF1A1F29); // Abu-abu
}
```