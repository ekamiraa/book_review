import 'package:book_review/contants/colors.dart';
import 'package:book_review/models/book.dart';
import 'package:book_review/models/reviews.dart';
import 'package:book_review/service/http_service.dart';
import 'package:book_review/widgets/custom_app_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailBooks extends StatefulWidget {
  final Book book;
  DetailBooks({super.key, required this.book});

  @override
  State<DetailBooks> createState() => _DetailBooksState();
}

class _DetailBooksState extends State<DetailBooks> {
  late HttpService httpService;
  late Future<List<Reviews>> futureReviews;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    httpService = HttpService();
    futureReviews = httpService.fetchBookReviews(
        'SWhf1oM2patuAr0L0ij0KZqFW7j3cVep', widget.book.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              Icons.arrow_back_ios,
              "Details Book",
              leftCallback: () {
                // Fungsi callback saat ikon kiri diklik
                Navigator.pop(context);
              },
            ),
            BookChoose(book: widget.book),
            Divider(),
            BookDescription(book: widget.book),
            Divider(),
            Container(
              margin: EdgeInsets.only(right: 250.0),
              child: Text(
                'Review',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),

            FutureBuilder<List<Reviews>>(
              future: futureReviews,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No reviews available.');
                } else {
                  return ReviewsList(reviews: snapshot.data!);
                }
              },
            ),
            // ReviewsList(book: widget.book),
          ],
        ),
      ),
    );
  }
}

class BookDescription extends StatelessWidget {
  final Book book;
  const BookDescription({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            child: Text(
              book.description,
              style: TextStyle(
                fontSize: 14.0,
                color: kFontLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookChoose extends StatelessWidget {
  final Book book;
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

  const BookChoose({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
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
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
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
                    itemSize: 12.0,
                    itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
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
    );
  }
}

class ReviewsList extends StatelessWidget {
  final List<Reviews> reviews;

  ReviewsList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: reviews.length,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.fromLTRB(15, 5, 20, 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container(
            //   padding: EdgeInsets.all(8.0),
            //   height: 70,
            //   width: 55,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     image: DecorationImage(
            //       image: AssetImage(listReview[index].profile),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 15,
                  left: 20,
                  right: 10,
                  bottom: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          reviews[index].byline,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // RatingBar.builder(
                        //   initialRating: book.rank.toDouble(),
                        //   minRating: 1,
                        //   direction: Axis.horizontal,
                        //   allowHalfRating: true,
                        //   itemCount: 5,
                        //   itemSize: 12.0,
                        //   itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                        //   itemBuilder: (context, _) => Icon(
                        //     Icons.star,
                        //     color: KPrimary,
                        //   ),
                        //   onRatingUpdate: (rating) {
                        //     print(rating);
                        //   },
                        // ),
                      ],
                    ),
                    Text(
                      "Summary:",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kFontLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      reviews[index].summary.isNotEmpty
                          ? reviews[index].summary
                          : "No summary available.",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kFontLight,
                      ),
                    ),
                    Text(
                      "Article:",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kFontLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      reviews[index].url.isNotEmpty
                          ? reviews[index].url
                          : "No article available.",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kFontLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
