import 'package:flutter/material.dart';
import 'package:book_review/contants/colors.dart';
import 'package:book_review/models/book.dart';
import 'package:book_review/screens/booklist/book_list.dart';
import 'package:book_review/screens/detail/detail_books.dart';
import 'package:book_review/widgets/custom_app_bar.dart';
import 'package:book_review/widgets/custom_bottom_navigation_bar.dart';
import 'package:book_review/service/http_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> books = [];
  late HttpService service;
  bool isLoading = true;
  late Future<List<Book>> futureNonFictionBooks;
  late Future<List<Book>> futureFictionBooks;

  @override
  void initState() {
    service = HttpService();
    futureFictionBooks = HttpService().fetchBook(704);
    futureNonFictionBooks = HttpService().fetchBook(708);

    // fetchBooks();
    super.initState();
  }

  void _onSearchPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? username = ModalRoute.of(context)?.settings.arguments as String?;

    if (username == null) {
      username = 'Eka Mira';
    }

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
                'Fiction',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListBestSellerBook(futureFictionBooks),
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                'Non-fiction',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListBestSellerBook(futureNonFictionBooks),
          ],
        ),
      ),
    );
  }
}

class EditorPicks extends StatelessWidget {
  final String highlight;

  const EditorPicks({Key? key, required this.highlight}) : super(key: key);

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

class ListBestSellerBook extends StatelessWidget {
  final Future<List<Book>> futureBooks;

  ListBestSellerBook(this.futureBooks);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: FutureBuilder<List<Book>>(
        future: futureBooks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailBooks(book: snapshot.data![index]),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                        ),
                        child: Image.network(
                          snapshot.data![index].book_image,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Icon(Icons.error);
                          },
                        ),
                      ),
                      SizedBox(height: 8.0),
                      SizedBox(
                        width: 100,
                        //height: 200,
                        child: Text(
                          snapshot.data![index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: 15),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            // Return a loading indicator or other placeholder widget
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
