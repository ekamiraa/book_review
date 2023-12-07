import 'package:book_review/contants/colors.dart';
import 'package:book_review/widgets/custom_app_bar.dart';
import 'package:book_review/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:book_review/screens/login/firebase_auth_service.dart';
import 'package:book_review/screens/login/login.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _originalEmailController = TextEditingController();
  TextEditingController _newEmailController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _originalPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Retrieve user data when the screen is initialized
    _getUserData();
  }

  void _getUserData() {
    // Retrieve user data from Firebase and set it in the text controllers
    User? user = _auth.currentUser;
    if (user != null) {
      _originalEmailController.text = user.email ?? "";
      // You can add more fields based on your data model
    }
  }

  void _updateProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        // Ensure the user is authenticated
        AuthCredential credential = EmailAuthProvider.credential(
          email: _originalEmailController.text,
          password: _originalPasswordController.text,
        );
        await user.reauthenticateWithCredential(credential);

        await user.verifyBeforeUpdateEmail(_newEmailController.text);

        await user.updatePassword(_newPasswordController.text);
        // Update email
        //await user.updateEmail(_newEmailController.text);

        // Send verification email to the new email address
        await user.sendEmailVerification();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Profile updated successfully. Check your email for verification."),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to update profile: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SingleChildScrollView(
        child: Column(children: [
          CustomAppBar(
            Icons.arrow_back_ios_outlined,
            "Edit Profile",
            leftCallback: () {
              // Fungsi callback saat ikon kiri diklik
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: TextField(
                    controller: _originalEmailController,
                    cursorColor: kFontLight,
                    decoration: InputDecoration(
                      labelText: "Original Email",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 244, 156, 3),
                      ),
                      hintText: "Enter original email",
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
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: TextField(
                    controller: _newEmailController,
                    cursorColor: kFontLight,
                    decoration: InputDecoration(
                      labelText: "New Email",
                      prefixIcon: Icon(
                        Icons.mark_email_unread_outlined,
                        color: Color.fromARGB(255, 244, 156, 3),
                      ),
                      hintText: "Enter new email address",
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
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: TextField(
                    controller: _originalPasswordController,
                    cursorColor: kFontLight,
                    decoration: InputDecoration(
                      labelText: "Original Password",
                      prefixIcon: Icon(
                        Icons.key,
                        color: Color.fromARGB(255, 244, 156, 3),
                      ),
                      hintText: "Enter original password",
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
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: TextField(
                    controller: _newPasswordController,
                    cursorColor: kFontLight,
                    decoration: InputDecoration(
                      labelText: "New Password",
                      prefixIcon: Icon(
                        Icons.key_off_outlined,
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
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromARGB(255, 244, 156, 3), // background color
                      onPrimary: Colors.white, // text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 3, // button shadow
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    onPressed: () {
                      _updateProfile();
                    },
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
