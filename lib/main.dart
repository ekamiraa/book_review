import 'package:book_review/screens/booklist/book_list.dart';
import 'package:book_review/screens/detail/detail_books.dart';
import 'package:book_review/screens/home/home.dart';
import 'package:book_review/screens/login/login.dart';
import 'package:book_review/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Book Review App",
        home: BookList(),
        routes: {
          '/home': (context) => HomePage(),
          // '/detail': (context) => DetailBooks(book: book),
        });
  }
}
