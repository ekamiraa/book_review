import 'dart:io';
import 'dart:convert';
import 'package:book_review/models/book.dart';
import 'package:http/http.dart' as http;

class HttpService {
  Future<List<Book>> fetchBook(int listId) async {
  final response = await http.get(Uri.parse(
      'https://api.nytimes.com/svc/books/v3/lists/full-overview.json?api-key=SWhf1oM2patuAr0L0ij0KZqFW7j3cVep'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final List<dynamic> data = jsonDecode(response.body)['results']['lists'];
    // return data.map((bookData) => Book.fromJson(bookData)).toList();
    // Find the list with the specified list_id
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
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

}
  

  //       if (lists != null && lists is List) {
  //         print("Response: $jsonResponse");
  //         List<Book> books = lists
  //             .expand((list) => (list['books'] as List?) ?? [])
  //             .map((bookJson) {
  //               print("Book JSON: $bookJson");
  //               return Book.fromJson(bookJson);
  //             })
  //             .toList();
  //         return books;
  //       } else {
  //         print("No books found in the response.");
  //         return [];
  //       }
  //     } else {
  //       print("Request failed with status: ${result.statusCode}");
  //       return [];
  //     }
  //   } catch (e) {
  //     print("Error fetching books: $e");
  //     return [];
  //   }
  // }

