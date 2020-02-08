import 'package:bookstore/src/models/books.dart';
import 'package:equatable/equatable.dart';

abstract class BooksState extends Equatable {
  const BooksState();

  @override
  List<Object> get props => [];
}

class BooksUnitialized extends BooksState {}

class BooksError extends BooksState {}

class BooksLoaded extends BooksState {
  final List<Books> books; 
  final bool hasReachedMax;

  const BooksLoaded({this.books, this.hasReachedMax});

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
      'PostLoaded { books: ${books.length}, hasReachedMax: $hasReachedMax }';
}
