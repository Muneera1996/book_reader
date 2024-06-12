import 'package:flutter/material.dart';

import '../components/gridview_widget.dart';
import '../models/book.dart';
import '../network/network.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Network network = Network();
  List<Book> _books = [];

  bool _isLoading = false; // Add this state variable

  Future<void> _searchBooks(String query) async {
    setState(() {
      _isLoading = true; // Set loading to true when search starts
    });

    try {
      List<Book> books = await network.searchBooks(query);
      setState(() {
        _books = books;
      });
    } catch (e) {
      // Handle the error appropriately here
    } finally {
      setState(() {
        _isLoading = false; // Set loading to false when search completes
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    hintText: 'Search for a book',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onSubmitted: (query) => _searchBooks(query),
              ),
            ),
            _isLoading ? const CircularProgressIndicator() : GridViewWidget(books: _books)
          ],
        ),
      ),
    );
  }
}
