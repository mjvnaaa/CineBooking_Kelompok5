= Bukti Keaslian Kode (Strict Mode)

== Watermark Code
Setiap kode memiliki inisial pembuat di nama class, fungsi, dan variabel:

```dart
// Contoh watermark dari kode program:
class MovieModelJevon {}          // Inisial "Jevon"
class HomePageAdel {}             // Inisial "Adel"
class SeatPageIntan {}            // Inisial "Intan"
class SeatControllerSalam {}      // Inisial "Salam"
class LoginPageBioskopFariz {}    // Inisial "Fariz"
```

== Logic Trap Implementasi Manual
```dart
// File: controllers/seat_controller.dart
int calculateTotalPrice() {
  int total = basePriceSalam * _selectedSeatsSalam.length;

  // Trap 1: Jika judul film > 10 karakter, tambah Rp 2.500 per kursi
  if (movieTitleSalam.length > 10) {
    total = total + (2500 * _selectedSeatsSalam.length);
  }

  // Trap 2: Kursi genap dapat diskon 10%
  for (var seat in _selectedSeatsSalam) {
    final number = int.tryParse(seat.substring(1)) ?? 0;
    if (number % 2 == 0) {
      total -= (basePriceSalam * 0.10).toInt();
    }
  }
  return total;
}
```