import 'package:book_review/contants/colors.dart';
import 'package:book_review/widgets/custom_app_bar.dart';
import 'package:book_review/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

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
  const DetailProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          title: Text("Your ID",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          subtitle: Text("12",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              )),
          leading: Icon(Icons.card_membership_rounded),
          onTap: () {},
        ),
        ListTile(
          title: Text("Name",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          subtitle: Text("Eka Mira",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              )),
          leading: Icon(Icons.person_add_alt_1_sharp),
          onTap: () {},
        ),
        ListTile(
          title: Text("Job",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          subtitle: Text("Teacher",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              )),
          leading: Icon(Icons.admin_panel_settings),
          onTap: () {},
        ),
        ListTile(
          title: Text("Logout",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          leading: Icon(Icons.logout_outlined),
          onTap: () {},
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      child: OutlinedButton(
        onPressed: (() {}),
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





// import 'package:book_review/contants/colors.dart';
// import 'package:book_review/widgets/custom_app_bar.dart';
// import 'package:book_review/widgets/custom_bottom_navigation_bar.dart';
// import 'package:flutter/material.dart';

// class Profile extends StatefulWidget {
//   Profile({super.key});

//   @override
//   State<Profile> createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kBackground,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             CustomAppBar(
//               Icons.arrow_back_ios_outlined,
//               "My Profile",
//               leftCallback: () {
//                 // Fungsi callback saat ikon kiri diklik
//                 Navigator.pop(context);
//               },
//             ),
//             SizedBox(
//               height: 10.0,
//             ),
//             DetailProfile(),
//             // ButtonEditProfile(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(),
//     );
//   }
// }

// class DetailProfile extends StatelessWidget {
//   DetailProfile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: ListView(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: 20, bottom: 15),
//               child: CircleAvatar(
//                 radius: 62,
//                 child: CircleAvatar(
//                   radius: 60,
//                   foregroundImage: NetworkImage(
//                       'https://images.unsplash.com/photo-1464863979621-258859e62245?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3386&q=80'),
//                 ),
//               ),
//             ),
//             Center(
//               child: Text(
//                 "Hello!",
//               ),
//             ),
//             Center(
//               child: Text(
//                 "You have become a member. Dive into Books, Pour Out Your Reviews.",
//               ),
//             ),
//             SizedBox(height: 25),
//             ListTile(
//               title: Text("Your ID",
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   )),
//               subtitle: Text("12",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w100,
//                   )),
//               leading: Icon(Icons.card_membership_rounded),
//               onTap: () {},
//             ),
//             ListTile(
//               title: Text("Name",
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   )),
//               subtitle: Text("Eka Mira",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w100,
//                   )),
//               leading: Icon(Icons.person_add_alt_1_sharp),
//               onTap: () {},
//             ),
//             ListTile(
//               title: Text("Job",
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   )),
//               subtitle: Text("Teacher",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w100,
//                   )),
//               leading: Icon(Icons.admin_panel_settings),
//               onTap: () {},
//             ),
//             ListTile(
//               title: Text("Logout"),
//               leading: Icon(Icons.logout_outlined),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ButtonEditProfile extends StatefulWidget {
//   ButtonEditProfile({super.key});

//   @override
//   State<ButtonEditProfile> createState() => _ButtonEditProfileState();
// }

// class _ButtonEditProfileState extends State<ButtonEditProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           OutlinedButton(
//             onPressed: (() {}),
//             style: OutlinedButton.styleFrom(
//               backgroundColor: Color.fromARGB(255, 225, 99, 71),
//               padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30.0),
//               ),
//             ),
//             child: Container(
//               child: Text(
//                 "Edit Profile",
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 190.0,
//           ),
//         ],
//       ),
//     );
//   }
// }
