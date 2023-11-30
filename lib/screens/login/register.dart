import 'package:flutter/material.dart';
import 'package:book_review/contants/colors.dart';
import 'login.dart';

// void main() {
//   runApp(const RegisterPage());
// }

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController idField = TextEditingController();
  TextEditingController emailField = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: idField,
              cursorColor: kFontLight,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.1),
                filled: true,
                contentPadding: EdgeInsets.all(15),
                border: InputBorder.none,
                hintText: "Enter your id",
                labelText: 'ID User',
                hintStyle: TextStyle(color: kFontLight, fontSize: 15.0),
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: emailField,
              cursorColor: kFontLight,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.1),
                filled: true,
                contentPadding: EdgeInsets.all(15),
                border: InputBorder.none,
                hintText: "Enter your email",
                labelText: 'Email',
                hintStyle: TextStyle(color: kFontLight, fontSize: 15.0),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: username,
              cursorColor: kFontLight,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.1),
                filled: true,
                contentPadding: EdgeInsets.all(15),
                border: InputBorder.none,
                hintText: "Enter your username",
                labelText: 'Username',
                hintStyle: TextStyle(color: kFontLight, fontSize: 15.0),
              ),
            ),
            TextField(
              controller: password,
              cursorColor: kFontLight,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.1),
                filled: true,
                contentPadding: EdgeInsets.all(15),
                border: InputBorder.none,
                hintText: "Enter your password",
                labelText: 'Password',
                hintStyle: TextStyle(color: kFontLight, fontSize: 15.0),
              ),
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(
              height: 18,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     // Pass the entered values to the LoginPage
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => LoginPage(
            //           idField: idField.text,
            //           email: emailField.text,
            //           username: username.text,
            //           password: password.text,
            //         ),
            //       ),
            //     );
            //   },
            //   child: Text('Simpan Data', style: TextStyle(fontSize: 18)),
            // ),
          ],
        ),
      ),
    );
  }
}
