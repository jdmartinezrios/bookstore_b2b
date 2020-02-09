import 'dart:async';
import 'dart:convert';

import 'package:bookstore/src/models/books.dart';
import 'package:bookstore/src/provider/api.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:bookstore/src/blocs/books_event.dart';
import 'package:bookstore/src/blocs/books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final http.Client httpClient;
  Api api = new Api();
  var page = 1;

  BooksBloc({@required this.httpClient});

  @override
  Stream<BooksState> transformEvents(
    Stream<BooksEvent> events,
    Stream<BooksState> Function(BooksEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  get initialState => BooksUninitialized();

  @override
  Stream<BooksState> mapEventToState(BooksEvent event) async* {
    final currentState = state;
    
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is BooksUninitialized) {
          final books = await _fetchBooks(0, 20);
          yield BooksLoaded(books: books, hasReachedMax: false);
          return;
        }
        if (currentState is BooksLoaded) {
          page++;
          final books = await _fetchBooksPerPage(page.toString());
          yield books.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : BooksLoaded(
                  books: currentState.books + books,
                  hasReachedMax: false,
                );
        }
      } catch (e) {
        print(e);
        yield BooksError();
      }
    }
  }

  bool _hasReachedMax(BooksState state) =>
      state is BooksLoaded && state.hasReachedMax;

  Future<List<Books>> _fetchBooks(int startIndex, int limit) async {
    final response = await httpClient.get(api.apiNewBooks);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var _books = data['books'] as List;
      return _books.map((rawBooks) {
        return Books(
          id: rawBooks['id'],
          title: rawBooks['title'],
          subtitle: rawBooks['subtitle'],
          isbn13: rawBooks['isbn13'],
          price: rawBooks['price'],
          image: rawBooks['image'],
          url: rawBooks['url'],
        );
      }).toList();
    } else {
      throw Exception('error fetching books');
    }
  }

  Future<List<Books>> _fetchBooksPerPage(String page) async {
    final response = await httpClient.get(api.apiPerPageBooks + page);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var _books = data['books'] as List;
      return _books.map((rawBooks) {
        return Books(
          id: rawBooks['id'],
          title: rawBooks['title'],
          subtitle: rawBooks['subtitle'],
          isbn13: rawBooks['isbn13'],
          price: rawBooks['price'],
          image: rawBooks['image'],
          url: rawBooks['url'],
        );
      }).toList();
    } else {
      throw Exception('error fetching books per page');
    }
  }
}
