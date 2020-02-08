import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  final apiUrl = 'https://api.itbook.store/1.0/new';

  getNewBoocks() async {
    http.Response response = await http.get(apiUrl);

    final jsonResponse = json.decode(response.body);

    return jsonResponse;
  }
}