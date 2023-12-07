import 'package:book_review/contants/colors.dart';
import 'package:book_review/widgets/custom_app_bar.dart';
import 'package:book_review/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:book_review/screens/login/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:book_review/screens/login/login.dart';
import 'package:book_review/screens/manipulate/edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Column(children: [
        CustomAppBar(
          Icons.arrow_back_ios_outlined,
          "My Profile",
          leftCallback: () {
            // Fungsi callback saat ikon kiri diklik
            Navigator.pop(context);
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        Expanded(child: DetailProfile()),
      ]),
    );
  }
}

class DetailProfile extends StatelessWidget {
  DetailProfile({
    Key? key,
  });
  @override
  FirebaseAuth _auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 15),
          child: CircleAvatar(
            radius: 50,
            child: CircleAvatar(
                radius: 50, foregroundImage: AssetImage("/profile_user.png")),
          ),
        ),
        Center(
          child: Text(
            "Hello!",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Center(
          child: Text(
            "You have become a member",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Center(
          child: Text(
            "Dive into Books, Pour Out Your Reviews.",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        SizedBox(height: 25),
        ListTile(
          title: Text("Your Email",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          subtitle: Text(user?.email ?? "",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              )),
          leading: Icon(Icons.card_membership_rounded),
          onTap: () {},
        ),
        ListTile(
          title: Text("Password",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          subtitle: Text(user?.providerData[0].providerId ?? "",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              )),
          leading: Icon(Icons.person_add_alt_1_sharp),
          onTap: () {},
        ),
        ListTile(
          title: Text("Logout",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          leading: Icon(Icons.logout_outlined),
          onTap: () {
            _auth.signOut();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
        SizedBox(
          height: 40,
        ),
        ButtonEditProfile(),
      ],
    );
  }
}

class ButtonEditProfile extends StatelessWidget {
  const ButtonEditProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      child: OutlinedButton(
        onPressed: () {
          // Navigate to the Edit Profile screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProfileScreen()),
          );
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 225, 99, 71),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Container(
          child: Text(
            "Edit Profile",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
