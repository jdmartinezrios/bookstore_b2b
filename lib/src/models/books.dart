import 'package:equatable/equatable.dart';

class Books extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String isbn13;
  final String price;
  final String image;
  final String url;
  final String authors;
  final String publisher;
  final String isbn10;
  final String pages;
  final String year;
  final String rating;
  final String desc;
  final String pdf;

  const Books({
    this.id,
    this.title,
    this.subtitle,
    this.isbn13,
    this.price,
    this.image,
    this.url,
    this.authors,
    this.publisher,
    this.isbn10,
    this.pages,
    this.year,
    this.rating,
    this.desc,
    this.pdf,
  });

  @override
  List<Object> get props => [
        id,
        title,
        subtitle,
        isbn13,
        price,
        image,
        url,
        authors,
        publisher,
        isbn10,
        pages,
        year,
        rating,
        desc
      ];

  @override
  String toString() => 'Books { id: $id}';
}
