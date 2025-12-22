= Implementasi Antarmuka & Auth

== Halaman Login & Register (Fariz)
- Validasi email harus menggunakan domain `@poliwangi.ac.id`

```dart
// lib/models/auth/register_page_fariz.dart
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

- Implementasi `SharedPreferences` untuk remember me
```dart
// CineBooking_Kelompok5/lib/models/auth/login_page_fariz.dart
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

```dart
// CineBooking_Kelompok5/lib/models/auth/login_page_fariz.dart
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

```dart
// CineBooking_Kelompok5/lib/models/auth/login_page_fariz.dart
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
- Error handling dengan snackbar

```dart
// File: models/auth/login_page_fariz.dart
if (emailErrorFariz || passErrorFariz) {
      farizShowErrorSnackbar("Please fill in all fields");
      return;
    }
```
```dart
// CineBooking_Kelompok5/lib/models/auth/login_page_fariz.dart
if (!regexEmail.hasMatch(email)) {
      farizShowErrorSnackbar("Email must use @poliwangi.ac.id");
      return;
    }
```
```dart
// CineBooking_Kelompok5/lib/models/auth/login_page_fariz.dart
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