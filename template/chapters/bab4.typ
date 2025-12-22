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
```dart
// lib/models/home/home_page_adel.dart
Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: movies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, i) {
                    return MovieCardAdel(
                      movie: movies[i],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                MovieDetailPageAdel(movie: movies[i]),
                          ),
                        );
                      },
                    );
```
- Hero animation pada poster film
```dart
// lib/models/home/movie_card_adel.dart
child: Hero(
                tag: movie.id,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Hero(
                tag: movie.id,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Image.network(
                        movie.poster_url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (ctx, error, stackTrace) => Container(
                          color: Colors.grey[800],
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 50,
                          ),
                        ),
                      ),
```
- Responsif untuk berbagai ukuran layar

```dart
// File: models/home/home_page_adel.dart
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int gridCount = screenWidth > 600 ? 3 : 2;
```

== Halaman Seat Selection (Intan)
- Grid kursi 6x6 dengan visual state:
```dart
// CineBooking_Kelompok5/lib/modules/seat/seat_page_intan.dart
child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6 * 5,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        childAspectRatio: 0.9,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                      ),
```
```dart
// CineBooking_Kelompok5/lib/modules/seat/seat_page_intan.dart
    String seatNameIntan =
                            "${rowLettersIntan[rowIndexIntan]}$colIndexIntan";
```
  - Abu-abu: Available
  ```dart
  // CineBooking_Kelompok5/lib/modules/seat/seat_page_intan.dart
  else {
      seatColorIntan = const Color(0xFF1A1F29);
      borderColorIntan = Colors.grey.shade700;
      seatIconIntan = null;
    }
  ```
  - Biru: Selected
  ```dart
  // CineBooking_Kelompok5/lib/modules/seat/seat_page_intan.dart
  else if (isSelectedIntan) {
      seatColorIntan = const Color(0xFF1A2634);
      borderColorIntan = Colors.amber.shade600;
      seatIconIntan = Icons.check;
    } 
  ```
  - Merah: Sold
  ```dart
// CineBooking_Kelompok5/lib/modules/seat/seat_page_intan.dart
  if (isSoldIntan) {
      seatColorIntan = const Color(0xFF2D1B1B);
      borderColorIntan = Colors.red.shade700;
      seatIconIntan = Icons.close;
    }
  ```
- Interaksi toggle select/unselect

```dart
lib/modules/seat/seat_page_intan.dartColor seatColorIntan;
onTapIntan: () {
                if (!soldIntan) {
                controller.toggleSeat(seatNameIntan);
                }
              },
```
Tap kursi available -> Selected
Tap lagi -> Unselect
Kursi sold -> tidak bisa dipilih
```dart
    return GestureDetector(
      onTap: isSoldIntan ? null : onTapIntan,
```