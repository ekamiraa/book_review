import 'package:book_review/contants/colors.dart';
import 'package:book_review/models/book.dart';
import 'package:book_review/screens/detail/detail_books.dart';
import 'package:book_review/widgets/custom_app_bar.dart';
import 'package:book_review/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
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
          children: [
            CustomAppBar(
              Icons.arrow_back_ios_outlined,
              "My BookList",
              leftCallback: () {
                // Fungsi callback saat ikon kiri diklik
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            SearchInput(),
            ItemMyBookList(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class SearchInput extends StatelessWidget {
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
              cursorColor: kFontLight,
              decoration: InputDecoration(
                  fillColor: Colors.white.withOpacity(0.1),
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                  border: InputBorder.none,
                  hintText: "Search books by genre, title, or author",
                  hintStyle: TextStyle(color: kFontLight, fontSize: 15.0)),
            ),
          ),
          Positioned(
            right: 40,
            top: 35,
            child: Container(
              child: Icon(Icons.search, color: kFontLight),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemMyBookList extends StatefulWidget {
  const ItemMyBookList({super.key});

  @override
  State<ItemMyBookList> createState() => _ItemMyBookListState();
}

class _ItemMyBookListState extends State<ItemMyBookList> {
  List<Book> allBooks = [
    ...Book.generateBestSellerBook(),
    ...Book.generateNewsBook(),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical, // Mengubah ke Axis.vertical
      itemCount: allBooks.length,
      itemBuilder: (context, index) {
        Book book = allBooks[index];
        return InkWell(
          onTap: () {
            // Navigasi ke halaman detail buku saat item diklik
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailBooks(book: book),
              ),
            );
          },
          child: Container(
            height: 140,
            margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  height: 135,
                  width: 85,
                  decoration: BoxDecoration(
                    color: KPrimary,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                        book.book_image,
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBar.builder(
                          initialRating: book.rate,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 18.0,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: KPrimary,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          book.title,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          book.author,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: KPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              book.publisher,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: kFontLight,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              child: Text(
                                "Buy now",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
