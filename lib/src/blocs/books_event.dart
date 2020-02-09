import 'package:equatable/equatable.dart';

abstract class BooksEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends BooksEvent {}

class Filter extends BooksEvent {
  final String data;

  Filter(this.data);
}

class ResetFetchData extends BooksEvent {}
