class Reviews {
  final String bookTitle;
  final String byline;
  final String summary;
  final String url;

  Reviews({
    required this.bookTitle,
    required this.byline,
    required this.summary,
    required this.url,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      bookTitle: json['book_title'] ?? "",
      byline: json['byline'] ?? "",
      summary: json['summary'] ?? "",
      url: json['url'] ?? "",
    );
  }
}
