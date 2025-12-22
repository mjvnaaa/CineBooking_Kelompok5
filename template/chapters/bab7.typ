= Implementasi Antarmuka & Auth

== Halaman Login & Register (Fariz)
Halaman Login dan Register digunakan untuk proses autentikasi pengguna sebelum mengakses aplikasi CineBooking. Modul ini mengelola input nama, email, dan password menggunakan TextEditingController untuk memudahkan validasi data.
```dart
class _RegisterPageBioskopFarizState extends State<RegisterPageBioskopFariz> {
  final nameControllerFariz = TextEditingController();
  final emailControllerFariz = TextEditingController();
  final passControllerFariz = TextEditingController();
  bool obscureFariz = true;
  bool isLoadingFariz = false;
  bool nameErrorFariz = false;
  bool emailErrorFariz = false;
  bool passErrorFariz = false;

  final regexEmailFariz = RegExp(r'^[a-zA-Z0-9._%+-]+@poliwangi\.ac\.id$');
```
Validasi email diterapkan dengan RegExp untuk memastikan pengguna menggunakan domain resmi kampus, sehingga akses aplikasi dibatasi hanya untuk pengguna yang valid. Selain itu, password divalidasi agar memenuhi ketentuan keamanan yang telah ditentukan.
=== Implementasi `SharedPreferences` untuk remember me
Fitur remember me diimplementasikan menggunakan SharedPreferences untuk menyimpan status login pengguna secara lokal pada perangkat. Status login disimpan dalam bentuk nilai boolean dengan key isLoggedIn.
```dart
Future<void> farizCheckLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePageAdel()),
      );
    }
  }
```
Saat aplikasi dijalankan, fungsi farizCheckLoginStatus() akan mengecek status login. Jika isLoggedIn bernilai true, pengguna langsung diarahkan ke halaman Home menggunakan Navigator.pushReplacement, sehingga halaman login tidak dapat diakses kembali melalui tombol back. Selain itu, fitur remember me juga menyimpan email dan password pengguna jika opsi diaktifkan. Data tersebut akan dimuat kembali secara otomatis ketika aplikasi dibuka.
```dart
Future<void> farizLoadLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      farizRememberMe = prefs.getBool('rememberMe') ?? false;
      if (farizRememberMe) {
        farizEmailController.text = prefs.getString('savedEmail') ?? "";
        farizPasswordController.text = prefs.getString('savedPassword') ?? "";
      }
    });
  }
```
Data login disimpan atau dihapus berdasarkan kondisi remember me yang dipilih pengguna.
```dart
Future<void> farizSaveLoginData(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    if (farizRememberMe) {
      await prefs.setString('savedEmail', email);
      await prefs.setString('savedPassword', password);
      await prefs.setBool('rememberMe', true);
    } else {
      await prefs.remove('savedEmail');
      await prefs.remove('savedPassword');
      await prefs.setBool('rememberMe', false);
    }
  }
```
== Error handling dengan snackbar
Penanganan kesalahan pada halaman Login dan Register diimplementasikan menggunakan SnackBar untuk memberikan umpan balik langsung kepada pengguna. Pendekatan ini memastikan pengguna mengetahui kesalahan input atau kegagalan proses autentikasi tanpa keluar dari halaman. Sistem terlebih dahulu melakukan validasi input dasar. Jika kolom email atau password belum diisi, maka aplikasi akan menampilkan pesan kesalahan.
```dart
if (emailErrorFariz || passErrorFariz) {
      farizShowErrorSnackbar("Please fill in all fields");
      return;
    }
```
Selanjutnya, email divalidasi menggunakan regular expression. Jika email tidak sesuai dengan domain kampus, maka pesan kesalahan akan ditampilkan.
```dart
if (!regexEmail.hasMatch(email)) {
      farizShowErrorSnackbar("Email must use @poliwangi.ac.id");
      return;
    }
```
Pada proses autentikasi dengan Firebase, aplikasi menangani berbagai kemungkinan error, seperti email tidak terdaftar, password salah, atau format email tidak valid. Setiap kesalahan ditampilkan dengan pesan yang sesuai agar mudah dipahami oleh pengguna.
```dart
} on FirebaseAuthException catch (e) {
      String message = "Login failed";
      if (e.code == 'user-not-found') message = "No user found for that email";
      if (e.code == 'wrong-password') message = "Wrong password provided";
      if (e.code == 'invalid-email') message = "Invalid email format";
      farizShowErrorSnackbar(message);
    } finally {
      if (mounted) setState(() => farizIsLoading = false);
    }
  }
```
Dengan penggunaan SnackBar, proses error handling menjadi lebih informatif dan meningkatkan pengalaman pengguna tanpa mengganggu alur aplikasi.