import 'package:bookstore/src/blocs/books_event.dart';
import 'package:bookstore/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookstore/src/blocs/books_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Boockstore B2B',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) =>
              BooksBloc(httpClient: http.Client())..add(Fetch()),
          child: HomePage(),
        ),
    );
  }
}
