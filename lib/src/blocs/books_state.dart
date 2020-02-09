import 'package:equatable/equatable.dart';

import 'package:bookstore/src/models/books.dart';

abstract class BooksState extends Equatable {
  const BooksState();

  @override
  List<Object> get props => [];
}

class BooksUninitialized extends BooksState {}

class BooksError extends BooksState {}

class BooksLoaded extends BooksState {
  final List<Books> books;
  final bool hasReachedMax;

  const BooksLoaded({
    this.books,
    this.hasReachedMax,
  });

  BooksLoaded copyWith({
    List<Books> books,
    bool hasReachedMax,
  }) {
    return BooksLoaded(
      books: books ?? this.books,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [books, hasReachedMax];

  @override
  String toString() =>
      'BooksLoaded { posts: ${books.length}, hasReachedMax: $hasReachedMax }';
}
