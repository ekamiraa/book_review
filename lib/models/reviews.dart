class Reviews {
  String profile;
  String name;
  String article;
  double rate;

  Reviews(
    this.profile,
    this.name,
    this.article,
    this.rate,
  );

  static List<Reviews> reviewBestSeller() {
    return [
      Reviews(
          "profile2.jpeg",
          "Richard E. Nichollis",
          "When an enormous transparent dome settles over a small town in Maine in Stephen King’s new novel, it’s just fine with Big Jim, the local tyrant-in-waiting, and his pet goon squad.",
          4.8),
      Reviews(
          "profile3.jpg",
          "Janet Maslin",
          "Stephen King’s latest novel, “11/22/63,” tells of a schoolteacher who travels back to 1958 to alter history, and falls in love as well.",
          4.5),
      Reviews(
          "profile1.jpg",
          "Jane Will",
          "Stephen King’s time traveler tries to undo some painful history.",
          5),
    ];
  }
}
