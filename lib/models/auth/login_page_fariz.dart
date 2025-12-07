import 'package:flutter/material.dart';
import 'register_page_fariz.dart';
import '../home/home_page_adel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageBioskopFariz extends StatefulWidget {
  const LoginPageBioskopFariz({super.key});

  @override
  State<LoginPageBioskopFariz> createState() => _LoginPageBioskopStateFariz();
}

class _LoginPageBioskopStateFariz extends State<LoginPageBioskopFariz> {
  final farizEmailController = TextEditingController();
  final farizPasswordController = TextEditingController();
  final regexEmail = RegExp(r'^[a-zA-Z0-9._%+-]+@poliwangi\.ac\.id$');

  bool farizObscurePassword = true;
  bool farizIsLoading = false;
  bool farizRememberMe = false;
  bool emailErrorFariz = false;
  bool passErrorFariz = false;

  @override
  void initState() {
    super.initState();
    farizLoadLoginData();
    farizCheckLoginStatus();
    farizLoadLoginData();
  }

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

  Future<void> farizHandleLogin() async {
    String email = farizEmailController.text.trim();
    String pass = farizPasswordController.text.trim();
    

    setState(() {
      emailErrorFariz = email.isEmpty;
      passErrorFariz = pass.isEmpty;
    });

    if (emailErrorFariz || passErrorFariz) {
      farizShowErrorSnackbar("Please fill in all fields");
      return;
    }

    if (!regexEmail.hasMatch(email)) {
      farizShowErrorSnackbar("Email must use @poliwangi.ac.id");
      return;
    }

    setState(() => farizIsLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      await farizSaveLoginData(email, pass);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePageAdel()),
      );
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

  void farizShowErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(fontSize: 14)),
            ),
          ],
        ),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  void dispose() {
    farizEmailController.dispose();
    farizPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/cinema_bg.jpg"),
                fit: BoxFit.cover,
                opacity: 0.4,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0F1419),
                  Color(0xCC0F1419),
                  Color(0xFF0F1419),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.movie_filter,
                          color: Colors.amber[600],
                          size: 40,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "CineBooking",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Book your favorite movie now!",
                      style: TextStyle(color: Colors.grey[400], fontSize: 15),
                    ),
                    const SizedBox(height: 48),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1F29),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey[800]!, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Welcome Back",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Sign in to continue",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 28),
                          TextField(
                            controller: farizEmailController,
                            enabled: !farizIsLoading,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFF0F1419),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.amber[600],
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: emailErrorFariz
                                      ? Colors.red
                                      : Colors.grey[800]!,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: emailErrorFariz
                                      ? Colors.red
                                      : Colors.grey[800]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: emailErrorFariz
                                      ? Colors.red
                                      : (Colors.amber[600] ?? Colors.amber),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          emailErrorFariz
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 6, left: 4),
                                  child: Text(
                                    "Email cannot be empty",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(height: 16),
                          TextField(
                            controller: farizPasswordController,
                            obscureText: farizObscurePassword,
                            enabled: !farizIsLoading,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFF0F1419),
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.amber[600],
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => setState(
                                  () => farizObscurePassword =
                                      !farizObscurePassword,
                                ),
                                icon: Icon(
                                  farizObscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.grey[500],
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: passErrorFariz
                                      ? Colors.red
                                      : Colors.grey[800]!,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: passErrorFariz
                                      ? Colors.red
                                      : Colors.grey[800]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: passErrorFariz
                                      ? Colors.red
                                      : Colors.amber[600] ?? Colors.amber,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          passErrorFariz
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 6, left: 4),
                                  child: Text(
                                    "Password cannot be empty",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Checkbox(
                                value: farizRememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    farizRememberMe = value ?? false;
                                  });
                                },
                                activeColor: Colors.amber[600],
                              ),
                              const Text(
                                "Remember me",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber[600],
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                                shadowColor: Colors.amber[600]!.withOpacity(
                                  0.4,
                                ),
                              ),
                              onPressed: farizIsLoading
                                  ? null
                                  : farizHandleLogin,
                              child: farizIsLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.login, size: 20),
                                        SizedBox(width: 8),
                                        Text(
                                          "Login",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                        TextButton(
                          onPressed: farizIsLoading
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const RegisterPageBioskopFariz(),
                                    ),
                                  );
                                },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.amber[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
