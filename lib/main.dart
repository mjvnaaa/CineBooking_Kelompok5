import 'package:cinebooking_kelompok5/controllers/seat_controller.dart';
import 'package:cinebooking_kelompok5/models/ticket/ticket_provider_fariz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/auth/login_page_fariz.dart';
import 'models/home/home_page_adel.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TicketProviderFariz()),
        ChangeNotifierProvider(create: (_) => SeatControllerSalam()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineBooking Tim 5',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(color: Colors.amber),
              ),
            );
          }

          final isLoggedIn = snapshot.data!;

          if (isLoggedIn) {
            return const HomePageAdel();
          } else {
            return const LoginPageBioskopFariz();
          }
        },
      ),
    );
  }
}
