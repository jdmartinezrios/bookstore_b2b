import 'package:equatable/equatable.dart';

class Books extends Equatable {
  final total;
  final books;

  const Books({this.total, this.books});

  @override
  List<Object> get props => [total.books];

  @override
  String toString() => 'Books {total:$total}';
}
