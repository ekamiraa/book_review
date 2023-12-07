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
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _originalEmailController,
              decoration: InputDecoration(labelText: "Original Email"),
            ),
            TextField(
              controller: _newEmailController,
              decoration: InputDecoration(labelText: "New Email"),
            ),
            TextField(
              controller: _originalPasswordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Update the profile when the button is pressed
                _updateProfile();
              },
              child: Text("Update Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
