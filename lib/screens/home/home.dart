import 'package:book_review/contants/colors.dart';
import 'package:book_review/models/book.dart';
import 'package:book_review/screens/booklist/book_list.dart';
import 'package:book_review/screens/detail/detail_books.dart';
import 'package:book_review/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onSearchPressed() {
    // Pindah ke halaman pencarian buku saat ikon pencarian diklik
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BookList(), // Ganti dengan halaman pencarian buku yang sesuai
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              Icons.arrow_back_ios_outlined,
              "Home",
              rightIcon: Icons.search,
              leftCallback: () {
                // Fungsi callback saat ikon kiri diklik
                Navigator.pop(context);
              },
              rightCallback: _onSearchPressed,
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  EditorPicks(highlight: "assets/highlight1.jpg"),
                  EditorPicks(highlight: "assets/highlight2.jpg"),
                  EditorPicks(highlight: "assets/highlight3.jpg"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                'Best Sellers',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListBestSellerBook(),
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                'News',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            listNewsBook(),
          ],
        ),
      ),
    );
  }
}

class EditorPicks extends StatelessWidget {
  final String highlight;

  const EditorPicks({super.key, required this.highlight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 25, 10, 15),
      child: Container(
        height: 150,
        width: 280,
        decoration: BoxDecoration(
          color: KPrimary,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(
              highlight,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ListBestSellerBook extends StatefulWidget {
  @override
  State<ListBestSellerBook> createState() => _ListBestSellerBookState();
}

class _ListBestSellerBookState extends State<ListBestSellerBook> {
  final itemBook = Book.generateBestSellerBook();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: itemBook.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            // Navigasi ke halaman detail buku saat item diklik
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailBooks(book: itemBook[index]),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 0, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 150,
                  width: 100,
                  decoration: BoxDecoration(
                    color: KPrimary,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(
                        itemBook[index].book_image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                SizedBox(
                  width: 100,
                  child: Text(
                    itemBook[index].title,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: 15),
      ),
    );
  }
}

class listNewsBook extends StatefulWidget {
  @override
  State<listNewsBook> createState() => _listNewsBookState();
}

class _listNewsBookState extends State<listNewsBook> {
  final itemBook = Book.generateNewsBook();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: itemBook.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            // Navigasi ke halaman detail buku saat item diklik
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailBooks(book: itemBook[index]),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 0, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 150,
                  width: 100,
                  decoration: BoxDecoration(
                    color: KPrimary,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(
                        itemBook[index].book_image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                SizedBox(
                  width: 100,
                  child: Text(
                    itemBook[index].title,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: 15),
      ),
    );
  }
}
