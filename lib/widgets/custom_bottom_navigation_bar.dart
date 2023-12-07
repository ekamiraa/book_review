import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:book_review/screens/booklist/book_list.dart';
import 'package:book_review/screens/detail/detail_books.dart';
import 'package:book_review/screens/home/home.dart';
import 'package:book_review/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

int _currentState = 0;

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  void gantiPage(int state) {
    setState(() {});
  }

  final List<BottomNavigationBarItem> bottomBarItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Person',
    ),
  ];

  final pages = [HomePage(), BookList(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentState],
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconSize: 25,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(
            color: Colors.black,
            size: 35,
          ),
          items: bottomBarItem,
          currentIndex: _currentState,
          mouseCursor: MaterialStateMouseCursor.clickable,
          selectedItemColor: Colors.black,
          onTap: (index) => setState(() => _currentState = index),
        ),
      ),
    );
  }
}
