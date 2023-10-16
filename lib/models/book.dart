import 'package:book_review/models/reviews.dart';

class Book {
  double rate;
  String title;
  String author;
  String description;
  String publisher;
  String book_image;
  String buy_links;
  List<Reviews> reviews;

  Book(this.rate, this.title, this.author, this.description, this.publisher,
      this.book_image, this.buy_links, this.reviews);

  static List<Book> generateBestSellerBook() {
    return [
      Book(
        5,
        "JUDGMENT PREY",
        "John Sandford",
        "The 33rd book in the Prey series. Davenport and Flowers investigate the murder of a federal judge and his two young sons.",
        "Putnam",
        "assets/book1.jpg",
        "https://www.amazon.com/dp/0593542819?tag=NYTBSREV-20",
        Reviews.reviewBestSeller(),
      ),
      Book(
        4,
        "HOLLY",
        "Stephen King",
        "The private detective Holly Gibney investigates whether a married pair of octogenarian academics had anything to do with Bonnie Dahl’s disappearance.",
        "Scribner",
        "assets/book2.jpg",
        "https://www.amazon.com/dp/1668016133?tag=NYTBSREV-20",
        Reviews.reviewBestSeller(),
      ),
      Book(
        4,
        "LESSONS IN CHEMISTRY",
        "Bonnie Garmus",
        "A scientist and single mother living in California in the 1960s becomes a star on a TV cooking show.",
        "Doubleday",
        "assets/book3.jpg",
        "https://www.amazon.com/dp/038554734X?tag=NYTBSREV-20",
        Reviews.reviewBestSeller(),
      ),
      Book(
        3.5,
        "THRONE OF THE FALLEN",
        "Kerri Maniscalco",
        "Camilla Antonius and the Prince of Envy try to avoid falling in love while journeying together through the Underworld.",
        "Little, Brown",
        "assets/book4.jpg",
        "https://www.amazon.com/dp/0316557293?tag=NYTBSREV-20",
        Reviews.reviewBestSeller(),
      ),
      Book(
        4.5,
        "SECOND ACT",
        "Danielle Steel",
        "The former head of a Hollywood studio thinks the unfinished novel written by a woman he hired to get his affairs in order could be adapted for the screen.",
        "Delacorte",
        "assets/book5.jpg",
        "https://www.amazon.com/dp/1984821954?tag=NYTBSREV-20"
            "https://www.amazon.com/dp/0316557293?tag=NYTBSREV-20",
        Reviews.reviewBestSeller(),
      ),
    ];
  }

  static List<Book> generateNewsBook() {
    return [
      Book(
        4.3,
        "12 MONTHS TO LIVE",
        "James Patterson and Mike Lupica",
        "A criminal defense attorney who received a terminal diagnosis might be in danger of being murdered.",
        "Little, Brown",
        "assets/book6.jpg",
        "https://www.amazon.com/dp/0316405698?tag=NYTBSREV-20",
        Reviews.reviewBestSeller(),
      ),
      Book(
        4,
        "STARLING HOUSE",
        "Alix E. Harrow",
        "An orphan hoping to improve things for her brother and herself goes inside a mansion connected to an author who disappeared over a century ago.",
        "Tor",
        "assets/book7.jpg",
        "https://www.amazon.com/dp/1250799058?tag=NYTBSREV-20",
        Reviews.reviewBestSeller(),
      ),
      Book(
        3.0,
        "TOM LAKE",
        "Ann Patchett",
        "Three daughters, who return to their family orchard in the spring of 2020, learn about their mother’s relationship with a famous actor.",
        "Harper",
        "assets/book8.jpg",
        "https://www.amazon.com/dp/006332752X?tag=NYTBSREV-20",
        Reviews.reviewBestSeller(),
      ),
      Book(
        3.0,
        "THE ARMOR OF LIGHT",
        "Ken Follett",
        "The fifth book in the Kingsbridge series. Change and turmoil affect various aspects of society in the latter part of the 18th century.",
        "Viking",
        "assets/book9.jpg",
        "https://www.amazon.com/dp/0525954996?tag=NYTBSREV-20",
        Reviews.reviewBestSeller(),
      ),
      Book(
        3.9,
        "DEMON COPPERHEAD",
        "Barbara Kingsolver",
        "Winner of a 2023 Pulitzer Prize for fiction. A reimagining of Charles Dickens’s “David Copperfield” set in the mountains of southern Appalachia.",
        "Harper",
        "assets/book10.jpg",
        "https://www.amazon.com/dp/1984821954?tag=NYTBSREV-20"
            "https://www.amazon.com/dp/0316557293?tag=NYTBSREV-20",
        Reviews.reviewBestSeller(),
      ),
    ];
  }
}
