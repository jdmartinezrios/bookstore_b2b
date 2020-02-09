import 'package:bookstore/src/models/books.dart';
import 'package:bookstore/src/pages/details_books.dart';
import 'package:bookstore/src/provider/api.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class BooksWidget extends StatefulWidget {
  final Books books;

  const BooksWidget({Key key, @required this.books}) : super(key: key);

  @override
  BooksWidgetState createState() => BooksWidgetState();
}

class BooksWidgetState extends State<BooksWidget> {
  Api api = new Api();
  var bookDetails;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                spreadRadius: 10.0,
                offset: Offset(0.0, 0.0))
          ]),
      child: GestureDetector(
        onTap: () async {
          await _getBooksDetails(widget.books.isbn13);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => BooksDetails(
                    title: bookDetails['title'],
                    subtitle: bookDetails['title'],
                    authors: bookDetails['authors'],
                    isbn13: bookDetails['isbn13'],
                    price: bookDetails['price'],
                    image: bookDetails['image'],
                    url: bookDetails['url'],
                    publisher: bookDetails['publisher'],
                    isbn10: bookDetails['isbn10'],
                    pages: bookDetails['pages'],
                    year: bookDetails['year'],
                    rating: bookDetails['rating'],
                    desc: bookDetails['desc'],
                  )));
        },
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100.0),
                  topRight: Radius.circular(100.0),
                  bottomLeft: Radius.circular(100.0),
                  bottomRight: Radius.circular(100.0)),
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: widget.books.isbn13,
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: widget.books.image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.contain),
                  ),
                  Positioned(
                    left: 0.0,
                    bottom: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 60.0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                      color: Colors.grey.withOpacity(0.90),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 2.0, left: 2.0, right: 2.0),
                        child: Text(widget.books.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.white,
                                fontFamily: "SFPro-Display-Bold")),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _getBooksDetails(String id) async {
    var details;
    await api.fetchBooksDetails(id).then((bookDetails) {
      details = bookDetails;
    });
    setState(() => bookDetails = details);
  }
}
