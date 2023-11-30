import 'package:book_review/screens/booklist/book_list.dart';
import 'package:book_review/screens/home/home.dart';
import 'package:book_review/screens/profile/profile.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final bottomBarItem = [
    Icons.home,
    Icons.search,
    Icons.person,
  ];

  int _selectedIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    BookList(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: bottomBarItem
            .asMap()
            .entries
            .map(
              (entry) => GestureDetector(
                onTap: () {
                  _onItemTapped(entry.key);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => pages[entry.key]),
                  );
                },
                child: Icon(
                  entry.value,
                  color:
                      _selectedIndex == entry.key ? Colors.black : Colors.grey,
                  size: 30,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
