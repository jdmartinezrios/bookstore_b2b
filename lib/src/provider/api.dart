import 'package:http/http.dart' as httpClient;
import 'dart:convert';

class Api {
  final String apiNewBooks = 'https://api.itbook.store/1.0/search/new';
  final String apiDetailsBooks = 'https://api.itbook.store/1.0/books/';
  final String apiPerPageBooks = 'https://api.itbook.store/1.0/search/mongodb/';
  final String apiFilter = 'https://api.itbook.store/1.0/search/';

  fetchBooksDetails(String id) async {
    final response = await httpClient.get(this.apiDetailsBooks + id);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('error fetching books details');
    }
  }
}
