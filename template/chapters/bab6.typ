= State Management & Logic

Dikerjakan oleh Transaction Logic Specialist[cite: 37].

== State Booking Seat
State management menggunakan (Provider/Bloc/GetX) untuk fitur *Book Now*[cite: 38, 39]. Pembuatan logika pemesanan kursi dilakukan dengan menggunakan Provider, pada baris pertama terdapat class dengan nama SeatControllerSalam sebagai controller state yang mengatur logika pemesanan kursi pada aplikasi. Class tersebut menggunakan ChangeNotifier sebagai pembaruan UI ketika ada perubahan data.
== Inisialisasi dan Deklarasi Variabel
```dart
final List<String> _selectedSeatsSalam = [];
List<String> get selectedSeats => _selectedSeatsSalam;
List<String> _soldSeatsSalam = [];
List<String> get soldSeats => _soldSeatsSalam;

int basePriceSalam = 0;
String movieTitleSalam = "";
StreamSubscription? _bookingSubscriptionSalam;
```
`_selectedSeatsSalam` variabel yang berfungsi untuk menyimpan kursi yang dipilih oleh pengguna melalui state lokal. `_soldSeatsSalam` variabel yang berfungsi untuk meyimpan kursi yang sudah dibeli, data diambil dari real-time Firestore. `basePrice` harga dasar untuk setiap kursi. `movieTitle` untuk menyimpan judul film yang dipilih. `_bookingSubscription` untuk menyimpan hasil monitoring perubahan data dari Firestore secara realtime.
== InitData() - Mengatur data awal
```dart
void initData({
  required int basePriceInput,
  required String movieTitleInput,
}) {
  basePriceSalam = basePriceInput;
  movieTitleSalam = movieTitleInput;
  _listenSoldSeatsSalam(movieTitleSalam);
}
```
== Logika Toggle dan Checkout
=== Toggle Seat
```dart
void toggleSeat(String seat) {
  if (_selectedSeatsSalam.contains(seat)) {
    _selectedSeatsSalam.remove(seat);
  } else {
    _selectedSeatsSalam.add(seat);
  }
  notifyListeners();
}
```
`toggleSeat(String seat)` memungkinkan pengguna memilih atau membatalkan pilihan kursi, kursi ditambahkan ke `_selectedSeatsSalam` jika belum dipilih, atau dihapus jika sudah ada, setiap perubahan memanggil `notifyListeners()` agar UI update.

=== Perhitungan Total Harga
```dart
int calculateTotalPrice() {
  int total = basePriceSalam * _selectedSeatsSalam.length;
  if (movieTitleSalam.length > 10) {
    total = total + (2500 * _selectedSeatsSalam.length);
  }
  for (var seat in _selectedSeatsSalam) {
    final number = int.tryParse(seat.substring(1)) ?? 0;
    if (number % 2 == 0) {
      total -= (basePriceSalam * 0.10).toInt();
    }
  }
  return total;
}
```
Logika diatas menghitung total berdasarkan jumlah kursi x harga dasar yang didapat dari `basePriceSalam`, tambahan biaya 2500 per kursi jika judul film lebih dari 10 karakter, Diskon 10% untuk kursi genap diambil dari nomor kursi. Total harga akan otomatis digunakan saat checkout.

=== Checkout
```dart
  Future<String?> checkout(String userId) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty || result[0].rawAddress.isEmpty) {
        return "Tidak ada koneksi internet. Silahkan cek jaringan Anda";
      }
    } catch (_) {
      return "Tidak ada koneksi internet. Silahkan cek jaringan Anda";
    }

    if (_selectedSeatsSalam.isEmpty || basePriceSalam == 0 || movieTitleSalam.isEmpty) {
      return "Data booking tidak lengkap";
    }

    final bookingCollection = FirebaseFirestore.instance.collection('bookings');
    final docRef = bookingCollection.doc();
    final bookingId = docRef.id;
    final data = {
      'booking_id': bookingId,
      'user_id': userId,
      'movie_title': movieTitleSalam,
      'seats': _selectedSeatsSalam,
      'total_price': calculateTotalPrice(),
      'booking_date': Timestamp.now(),
    };

    await docRef.set(data);
    await FirebaseFirestore.instance.collection("bookings").where("movie_title", isEqualTo: movieTitleSalam).snapshots().first;
    _selectedSeatsSalam.clear();
    notifyListeners();
    return null;
  }
```
Melakukan checkout dengan memeriksa koneksi internet terlebih dahulu. Jika tidak ada, akan mengembalikan pesan error dan validasi data booking. Untuk validasi data booking, jika kursi belum dipilih, harga belum diatur, atau judul film kosong, maka akan mengembalikan pesan error. Penyimpanan data booking ke Firestore di koleksi `bookings`, field yang disimpan `booking_id`, `user_id`, `movie_title`, `seats`, `total_price`, `booking_date`. Setelah booking berhasil, `_selectedSeatsSalam` akan dikosongkan untuk memulai transaksi baru.
