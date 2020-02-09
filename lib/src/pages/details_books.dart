import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class BooksDetails extends StatelessWidget {
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

  const BooksDetails(
      {this.title,
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
      this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 20.0,
              top: 40.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.grey.withOpacity(0.9),
                  size: 30.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
              width: double.infinity,
              child: Text(
                this.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey.withOpacity(0.9),
                    fontSize: 18.0,
                    decoration: TextDecoration.none),
              ),
            ),
            Hero(
              tag: this.isbn13,
              child: Container(
                margin: EdgeInsets.only(top: 160.0, left: 20.0, right: 20.0),
                width: double.infinity,
                height: 200.0,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: this.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 400.0, left: 20.0, right: 20.0, bottom: 40.0),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildTexts(this.publisher),
                  _buildTexts(this.subtitle),
                  _buildTexts(this.pages),
                  _buildTexts(this.price),
                  _buildTexts(this.rating),
                  _buildTexts(this.url),
                  _buildTexts(this.year),
                  _buildTexts(this.authors),
                  _buildTexts(this.desc),
                  _buildTexts(this.isbn10),
                  _buildTexts(this.isbn13),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTexts(String value) => Text(
        value,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.grey.withOpacity(0.9),
            fontSize: 14.0,
            decoration: TextDecoration.none),
      );
}
