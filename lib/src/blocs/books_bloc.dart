import 'package:bookstore/src/blocs/books_event.dart';
import 'package:bookstore/src/blocs/books_state.dart';
import 'package:bookstore/src/middleware/api.dart';
import 'package:bookstore/src/models/books.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final http.Client httpClient;

  BooksBloc({@required this.httpClient});
  Api api = new Api();

  @override
  Stream<BooksState> transformEvents(events, next
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  get initialState => BooksUnitialized();

  @override
  Stream<BooksState> mapEventToState(event) async* {
    final currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is BooksUnitialized) {
          final posts = await _fetchPosts(0, 20);
          yield BooksLoaded(books: posts, hasReachedMax: false);
        }
        if (currentState is BooksLoaded) {
          final posts = await _fetchPosts(currentState.books.length, 20);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : BooksLoaded(
                  books: currentState.books + posts, hasReachedMax: false);
        }
      } catch (_) {
        yield BooksError();
      }
    }
  }

  bool _hasReachedMax(BooksState state) =>
      state is BooksLoaded && state.hasReachedMax;

  Future<List<Books>> _fetchPosts(int startIndex, int limit) async {
    final response = await httpClient.get(
        api.apiNewBooks);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawBooks) {
        return Books(
          total: rawBooks['total'],
          books: rawBooks['books'],
        );
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}