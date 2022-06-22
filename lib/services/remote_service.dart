import 'dart:convert';
import 'package:http/http.dart ' as http;

import '../models/book_model.dart';

class RemoteService {
  static Future<List<BookElement>> fetchBooks(String query) async {
    var client = http.Client();
    var uri = Uri.parse('https://api.itbook.store/1.0/search/${query}');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      List<BookElement> jsonResponseList = json
          .decode(response.body)['books']
          .map<BookElement>((data) => BookElement.fromJson(data))
          .toList();

      return jsonResponseList;
    } else {
      throw Exception('failed to load books from API');
    }
  }
}
