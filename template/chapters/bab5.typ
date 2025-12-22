= Implementasi Halaman Seat Selection
== Implementasi Halaman Seat Selection
Halaman Seat Selection merupakan halaman untuk memilih kursi bioskop sebelum melakukan pembayaran tiket. Halaman ini dikerjakan oleh Intan sebagai Frontend Engineer pada modul Seat Matrix. Tampilan halaman dibuat menggunakan widget Scaffold dengan bagian body utama menampilkan grid kursi.
```dart
return Scaffold(
  backgroundColor: const Color(0xFF0F1419),
  appBar: AppBar(
    backgroundColor: const Color(0xFF1A1F29),
    title: Text("Pilih Kursi"),
  ),
```
Pada bagian `AppBar`, ditambahkan tombol kembali (Back) di sisi kiri agar pengguna dapat kembali ke halaman detail film tanpa kehilangan data kursi yang telah dipilih.

== Grid Kursi Dinamis
Kursi ditampilkan dalam bentuk grid menggunakan `GridView.builder` dengan konfigurasi dinamis, misalnya 6×8, agar tampilan kursi lebih rapi dan responsif di berbagai ukuran layar.
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 6,
  ),
  itemBuilder: (context, index) {
    return SeatItemIntan(
      seatNameIntan: seats[index].name,
      isSoldIntan: seats[index].isSold,
      isSelectedIntan: seats[index].isSelected,
      onTapIntan: () => controller.toggleSeat(seats[index].name),
    );
  },
)
```
Widget kursi dinamai `SeatItemIntan` sesuai ketentuan. Status kursi diperbarui secara real-time menggunakan Provider `SeatControllerSalam`.

== Status Visual Kursi
Setiap kursi memiliki tiga status yang ditandai dengan warna berbeda:
```dart
if (isSoldIntan) {
  seatColorIntan = Color(0xFFFF0000);
} else if (isSelectedIntan) {
  seatColorIntan = Color(0xFF1A2634);
} else {
  seatColorIntan = Color(0xFFAAAAAA);
}
```
Abu-abu: kursi tersedia, Biru: kursi dipilih (user dapat toggle select/unselect), Merah: kursi terjual (tidak bisa diklik)
== Perhitungan Total Harga
Total harga tiket dihitung otomatis berdasarkan jumlah kursi yang dipilih dan harga dasar per kursi. Nilai ini ditampilkan di bagian bawah halaman agar pengguna dapat melihat total pembayaran sebelum melanjutkan.
```dart 
 double totalPrice = controller.calculateTotalPrice();
```

== Navigasi ke pembayaran
Setelah memilih kursi, pengguna dapat menekan tombol Proceed to Payment untuk melanjutkan proses pemesanan tiket.
```dart
FloatingActionButton.extended(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentPage(
          selectedSeats: controller.selectedSeats,
          totalPrice: controller.calculateTotalPrice(),
        ),
      ),
    );
  },
  label: Text("Proceed to Payment"),
)
```

== Kesimpulan
Modul Seat Selection yang dikerjakan oleh Intan berhasil menampilkan grid kursi dinamis dengan status kursi yang jelas, toggle select/unselect interaktif, dan perhitungan harga otomatis. Antarmuka ini responsif dan intuitif sehingga memudahkan pengguna memilih kursi dengan nyaman sebelum melakukan pembayaran tiket.