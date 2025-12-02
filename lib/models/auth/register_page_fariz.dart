import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPageBioskopFariz extends StatefulWidget {
  const RegisterPageBioskopFariz({super.key});

  @override
  State<RegisterPageBioskopFariz> createState() => _RegisterPageBioskopFarizState();
}

class _RegisterPageBioskopFarizState extends State<RegisterPageBioskopFariz> {
  final nameControllerFariz = TextEditingController();
  final emailControllerFariz = TextEditingController();
  final passControllerFariz = TextEditingController();
  bool obscureFariz = true;
  bool isLoadingFariz = false;
  bool nameErrorFariz = false;
  bool emailErrorFariz = false;
  bool passErrorFariz = false;


  Future<void> registerUserFariz() async {
    String usernameFariz = nameControllerFariz.text.trim();
    String emailFariz = emailControllerFariz.text.trim();
    String passwordFariz = passControllerFariz.text.trim();

    if (usernameFariz.isEmpty || emailFariz.isEmpty || passwordFariz.isEmpty) {
      showErrorSnackbarFariz("Please fill all fields");
      return;
    }

    if (usernameFariz.length < 3) {
      showErrorSnackbarFariz("Username must be at least 3 characters");
      return;
    }

    if (passwordFariz.length < 6) {
      showErrorSnackbarFariz("Password must be at least 6 characters");
      return;
    }

    setState(() => isLoadingFariz = true);
    setState(() {
    nameErrorFariz = usernameFariz.isEmpty || usernameFariz.length < 3;
    emailErrorFariz = emailFariz.isEmpty;
    passErrorFariz = passwordFariz.isEmpty || passwordFariz.length < 6;
});

    try {
      UserCredential userCredentialFariz = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailFariz, password: passwordFariz);

      String uidFariz = userCredentialFariz.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uidFariz).set({
        'uid': uidFariz,
        'email': emailFariz,
        'username': usernameFariz,
        'balance': 0,
        'createdAt': Timestamp.now(),
        // tambahan inisial fariz sesuai permintaan
        'inisial_fariz': true,
      });

      if (!mounted) return;

      showSuccessSnackbarFariz("Account created successfully!");

      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String messageFariz = "Registration failed";

      if (e.code == 'email-already-in-use') {
        messageFariz = "Email is already in use";
      } else if (e.code == 'weak-password') {
        messageFariz = "Password is too weak";
      } else if (e.code == 'invalid-email') {
        messageFariz = "Invalid email format";
      }

      showErrorSnackbarFariz(messageFariz);
    } catch (e) {
      showErrorSnackbarFariz("An error occurred. Please try again");
    } finally {
      if (mounted) setState(() => isLoadingFariz = false);
    }
  }

  void showErrorSnackbarFariz(String messageFariz) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(messageFariz, style: const TextStyle(fontSize: 14)),
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

  void showSuccessSnackbarFariz(String messageFariz) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(messageFariz, style: const TextStyle(fontSize: 14)),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  void dispose() {
    nameControllerFariz.dispose();
    emailControllerFariz.dispose();
    passControllerFariz.dispose();
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1F29),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[800]!),
                          ),
                          child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                        ),
                        onPressed: isLoadingFariz ? null : () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.movie_filter, color: Colors.amber[600], size: 36),
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
                            "Create your account",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 40),
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
                                  "Join Us Today",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Sign up to start booking",
                                  style: TextStyle(color: Colors.grey[500], fontSize: 14),
                                ),
                                const SizedBox(height: 28),
                                TextField(
                                  controller: nameControllerFariz,
                                  enabled: !isLoadingFariz,
                                  textCapitalization: TextCapitalization.words,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFF0F1419),
                                    hintText: "Full Name",
                                    hintStyle: TextStyle(color: Colors.grey[600]),
                                    prefixIcon: Icon(Icons.person_outline, color: Colors.amber[600]),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.grey[800]!),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.grey[800]!),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.amber[600]!, width: 2),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: emailControllerFariz,
                                  enabled: !isLoadingFariz,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFF0F1419),
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey[600]),
                                    prefixIcon: Icon(Icons.email_outlined, color: Colors.amber[600]),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.grey[800]!),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.grey[800]!),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.amber[600]!, width: 2),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: passControllerFariz,
                                  obscureText: obscureFariz,
                                  enabled: !isLoadingFariz,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFF0F1419),
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey[600]),
                                    prefixIcon: Icon(Icons.lock_outline, color: Colors.amber[600]),
                                    suffixIcon: IconButton(
                                      onPressed: () => setState(() => obscureFariz = !obscureFariz),
                                      icon: Icon(
                                        obscureFariz ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.grey[800]!),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.grey[800]!),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.amber[600]!, width: 2),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber[600],
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 4,
                                      shadowColor: Colors.amber[600]!.withOpacity(0.4),
                                    ),
                                    onPressed: isLoadingFariz ? null : registerUserFariz,
                                    child: isLoadingFariz
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                              strokeWidth: 2.5,
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.person_add, size: 20),
                                              SizedBox(width: 8),
                                              Text(
                                                "Create Account",
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
                                "Already have an account?",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              TextButton(
                                onPressed: isLoadingFariz ? null : () => Navigator.pop(context),
                                child: Text(
                                  "Login",
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
          ),
        ],
      ),
    );
  }
}