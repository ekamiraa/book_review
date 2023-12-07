import 'package:book_review/contants/colors.dart';
import 'package:book_review/screens/login/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
import 'package:book_review/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user =
        await _authService.loginWithEmailAndPassword(email, password, context);

    if (user != null) {
      // User is successfully created
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login success"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamedAndRemoveUntil(
          context, '/bottomnavbar', (route) => false);
    } else {
      // Cannot create user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar
            Container(
              height: 180, // Sesuaikan tinggi gambar sesuai kebutuhan
              width: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('login.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(
                    90.0), // Setengah dari tinggi/lebar untuk membuat gambar lingkaran
              ),
            ),
            const SizedBox(
                height: 10.0), // Jarak antara gambar dan teks "Login"
            // Teks "Login"
            const Text(
              "Login",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 244, 156, 3),
              ),
            ),
            const SizedBox(
                height: 10.0), // Jarak antara teks "Login" dan TextField
            // TextField Email
            TextField(
              controller: _emailController,
              cursorColor: kFontLight,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: Color.fromARGB(255, 244, 156, 3),
                ),
                hintText: "Email Address",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 244, 156, 3),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[400]!,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            // TextField Password
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.key,
                  color: Color.fromARGB(255, 244, 156, 3),
                ),
                hintText: "Password",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 244, 156, 3),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[400]!,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 244, 156, 3), // background color
                  onPrimary: Colors.white, // text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 3, // button shadow
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: () {
                  login();
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                const SizedBox(
                  width: 4.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  child: const Text(
                    "Register.",
                    style: TextStyle(color: Color.fromARGB(255, 244, 156, 3)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
