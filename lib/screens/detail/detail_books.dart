import 'package:book_review/contants/colors.dart';
import 'package:book_review/models/book.dart';
import 'package:book_review/models/reviews.dart';
import 'package:book_review/widgets/custom_app_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailBooks extends StatelessWidget {
  final Book book;
  DetailBooks({super.key, required this.book});

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
            BookChoose(book: book),
            Divider(),
            BookDescription(book: book),
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
            ReviewBook(book: book),
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
      image: NetworkImage(book.book_image), // Use NetworkImage for loading images from URLs
      fit: BoxFit.cover,
    ),
  ),
  child: Image.network(
    book.book_image,
    fit: BoxFit.cover,
    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      }
    },
    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
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


class ReviewBook extends StatelessWidget {
  final listReview = Reviews.reviewBestSeller();
  final Book book;
  
  ReviewBook({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: listReview.length,
      itemBuilder: (context, index) => Container(
        height: 170,
        margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              height: 70,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(listReview[index].profile),
                  fit: BoxFit.cover,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listReview[index].name,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RatingBar.builder(
                          initialRating: book.rank.toDouble(),
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
                      ],
                    ),
                    Text(
                      listReview[index].article,
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
