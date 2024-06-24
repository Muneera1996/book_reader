import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Country.dart';
import '../models/book.dart';

class Network {
  // API endpoints
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';
  static const String _appUrl = 'http://192.168.1.6:3000/'; // IP of development machine

  Future<Country> getCountry() async {
    var finalUrl = "${_appUrl}countries";
    print("url: ${finalUrl}");

    var url = Uri.parse(finalUrl);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print("response: ${response.body}");
      return Country.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error getting Country");
    }
  }

  Future<List<Book>> searchBooks(String query) async {
    var url = Uri.parse('$_baseUrl?q=$query');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['items'] != null && data['items'] is List) {
        List<Book> books = (data['items'] as List<dynamic>)
            .map((book) => Book.fromJson(book as Map<String, dynamic>))
            .toList();
        return books;
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<Map<String, dynamic>?> signUp(String email, String password, String firstname, String lastname, String mobile) async {
    var url = Uri.parse('${_appUrl}users/signup');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'firstname': firstname,
        'lastname': lastname,
        'mobile': mobile
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      showError(response);
    }
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    var url = Uri.parse('${_appUrl}users/signin');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<void> logout() async {
    var url = Uri.parse('${_appUrl}users/logout');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to log out');
    }
  }

  void showError(http.Response? response) {
    // Handle error response
    var errorMessage = "Something went wrong. Status code: ${response?.statusCode}";
    if (response?.body != null && response!.body.isNotEmpty) {
      errorMessage = json.decode(response.body)['message'];
    }
    throw Exception(errorMessage);
  }
}
