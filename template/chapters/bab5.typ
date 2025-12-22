= State Management & Logic

== State Management (Salam)
Menggunakan `ChangeNotifier` untuk mengelola state kursi yang dipilih:

```dart
// File: controllers/seat_controller.dart
class SeatControllerSalam with ChangeNotifier {
  final List<String> _selectedSeatsSalam = [];
  List<String> get selectedSeats => _selectedSeatsSalam;
  
  void toggleSeat(String seat) {
    if (_selectedSeatsSalam.contains(seat)) {
      _selectedSeatsSalam.remove(seat);
    } else {
      _selectedSeatsSalam.add(seat);
    }
    notifyListeners();
  }
}
```

== Real-time Sold Seats Tracking
Menggunakan `StreamSubscription` untuk update kursi yang sudah terjual secara real-time:

```dart
void _listenSoldSeatsSalam(String movieTitle) {
  _bookingSubscriptionSalam = FirebaseFirestore.instance
      .collection("bookings")
      .where("movie_title", isEqualTo: movieTitle)
      .snapshots()
      .listen((snapshot) {
        // Update sold seats
        notifyListeners();
      });
}
```

== Checkout Process
Validasi koneksi internet sebelum melakukan booking:

```dart
Future<String?> checkout(String userId) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isEmpty) {
      return "Tidak ada koneksi internet";
    }
  } catch (_) {
    return "Tidak ada koneksi internet";
  }
  // ... proses booking
}
```