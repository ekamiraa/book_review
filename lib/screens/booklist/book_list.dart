import 'package:book_review/contants/colors.dart';
import 'package:book_review/models/book.dart';
import 'package:book_review/screens/detail/detail_books.dart';
import 'package:book_review/widgets/custom_app_bar.dart';
import 'package:book_review/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:book_review/service/http_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class BookList extends StatefulWidget {
  BookList({super.key});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  List<Book> books = [];
  late HttpService httpService;
  bool isLoading = true;
  late Future<List<Book>> futureNonFictionBooks;
  late Future<List<Book>> futureFictionBooks;
  late TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    httpService = HttpService();
    futureFictionBooks = httpService.fetchBook(704);
    futureNonFictionBooks = httpService.fetchBook(708);

    // Initialize the books list when both futures are completed
    Future.wait([futureFictionBooks, futureNonFictionBooks])
        .then((List<List<Book>> results) {
      setState(() {
        // Combine the lists and shuffle them
        books = results.expand((list) => list).toList()..shuffle();
        isLoading = false;
      });
    });
  }

  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      // If the search field is empty, reset to the original list
      Future.wait([futureFictionBooks, futureNonFictionBooks])
          .then((List<List<Book>> results) {
        setState(() {
          // Combine the lists and shuffle them
          books = results.expand((list) => list).toList()..shuffle();
          isLoading = false;
        });
      });
    } else {
      List<Book> results = books
          .where((book) =>
              book.title.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              book.author
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              book.publisher
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();

      setState(() {
        books = results;
      });
    }
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
            SearchInput(
                searchController: searchController, onSearch: _runFilter),
            ItemBookList(books: books),
          ],
        ),
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;

  SearchInput({required this.searchController, required this.onSearch});
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
              controller: searchController,
              onChanged: onSearch,
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

class ItemBookList extends StatelessWidget {
  final List<Book> books;
  const ItemBookList({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    double calculateRating(int rank) {
      if (rank >= 1 && rank <= 4) {
        return 5.0;
      } else if (rank >= 5 && rank <= 8) {
        return 4.0;
      } else if (rank >= 9 && rank <= 12) {
        return 3.0;
      } else if (rank >= 13 && rank <= 15) {
        return 2.0;
      } else {
        // Handle other cases if needed
        return 0.0; // Default value
      }
    }

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical, // Mengubah ke Axis.vertical
      itemCount: books.length,
      itemBuilder: (context, index) {
        Book book = books[index];
        return InkWell(
          onTap: () {
            // Navigasi ke halaman detail buku saat item diklik
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailBooks(book: books[index]),
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
                  height: 150,
                  width: 100,
                  decoration: BoxDecoration(
                    color: KPrimary,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(book
                          .book_image), // Use NetworkImage for loading images from URLs
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Image.network(
                    book.book_image,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      print("Error loading image: $error");
                      return Icon(Icons.error);
                    },
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
                          initialRating: calculateRating(book.rank),
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          book.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
