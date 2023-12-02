import 'dart:io';
import 'dart:convert';
import 'package:book_review/models/book.dart';
import 'package:book_review/models/reviews.dart';
import 'package:http/http.dart' as http;

class HttpService {
  Future<List<Book>> fetchBook(int listId) async {
    final response = await http.get(Uri.parse(
        'https://api.nytimes.com/svc/books/v3/lists/full-overview.json?api-key=SWhf1oM2patuAr0L0ij0KZqFW7j3cVep'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results']['lists'];
      var selectedList = data.firstWhere(
        (list) => list['list_id'] == listId,
        orElse: () => null,
      );
      if (selectedList != null) {
        final List<dynamic> booksData = selectedList['books'];
        return booksData.map((bookData) => Book.fromJson(bookData)).toList();
      } else {
        throw Exception('List with list_id $listId not found');
      }
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Reviews>> fetchBookReviews(String apiKey, String title) async {
    final response = await http.get(Uri.parse(
        'https://api.nytimes.com/svc/books/v3/reviews.json?api-key=$apiKey&title=$title'));

    if (response.statusCode == 200) {
      final List<dynamic> reviewsData = jsonDecode(response.body)['results'];
      return reviewsData
          .map((reviewData) => Reviews.fromJson(reviewData))
          .toList();
    } else {
      throw Exception('Failed to load book reviews');
    }
  }
}
