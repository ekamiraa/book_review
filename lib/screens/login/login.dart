import 'package:book_review/contants/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Image.asset("login.jpg"),
          Text(
            "Login",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          MyUsername(usernameController: _usernameController),
          MyPassword(passwordController: _passwordController),
          Spacer(),
          OutlinedButton(
            onPressed: (() {
              String username = _usernameController.text;
              Navigator.pushNamed(context, '/home', arguments: username);
            }),
            child: Container(
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }
}

class MyUsername extends StatelessWidget {
  const MyUsername({
    super.key,
    required TextEditingController usernameController,
  }) : _usernameController = usernameController;

  final TextEditingController _usernameController;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: kFontLight.withOpacity(0.3),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            child: TextField(
              controller: _usernameController,
              cursorColor: kFontLight,
              decoration: InputDecoration(
                  fillColor: Colors.white.withOpacity(0.1),
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                  border: InputBorder.none,
                  hintText: "Enter your username",
                  hintStyle: TextStyle(color: kFontLight, fontSize: 15.0)),
            ),
          ),
          Positioned(
            right: 40,
            top: 35,
            child: Container(
              child: Icon(Icons.person, color: kFontLight),
            ),
          ),
        ],
      ),
    );
  }
}

class MyPassword extends StatelessWidget {
  const MyPassword({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: kFontLight.withOpacity(0.3),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            child: TextField(
              controller: _passwordController,
              cursorColor: kFontLight,
              decoration: InputDecoration(
                  fillColor: Colors.white.withOpacity(0.1),
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                  border: InputBorder.none,
                  hintText: "Enter your password",
                  hintStyle: TextStyle(color: kFontLight, fontSize: 15.0)),
            ),
          ),
          Positioned(
            right: 40,
            top: 35,
            child: Container(
              child: Icon(Icons.key, color: kFontLight),
            ),
          ),
        ],
      ),
    );
  }
}
