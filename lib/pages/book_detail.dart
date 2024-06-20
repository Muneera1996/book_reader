import 'package:book_reader/notifiers/AppNotifier.dart';
import 'package:book_reader/themes/light_color.dart';
import 'package:book_reader/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/database_helper.dart';
import '../utils/book_details_arguments.dart';
import '../models/book.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {

  bool _isBookSaved = false;
  late Book book;
  late bool isFromSavedScreen;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    book = args.itemBook;
    isFromSavedScreen = args.isFromSavedScreen;
    _checkIfBookIsSaved();
  }

  Future<void> _checkIfBookIsSaved() async {
    bool exists = await DatabaseHelper.instance.bookExists(book.id);
    setState(() {
      _isBookSaved = exists;
    });
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context).textTheme;

    return Scaffold(
      floatingActionButton: Builder(builder: (context) => _floatingButton(context,book)),
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if (book.imageLinks.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    book.imageLinks['thumbnail'] ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    book.title,
                    style: theme.headlineSmall,
                  ),
                  Text(
                    book.authors.join(', '),
                    style: theme.labelLarge,
                  ),
                  Text(
                    'Published: ${book.publishedDate}',
                    style: theme.bodySmall,
                  ),
                  Text(
                    'Page count: ${book.pageCount}',
                    style: theme.bodySmall,
                  ),
                  Text(
                    'Language: ${book.language}',
                    style: theme.bodySmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      child: !isFromSavedScreen
                          ? ElevatedButton(
                          onPressed: () async {
                            // save a book to the datase
                            try {
                              book.save = 1;
                              int savedInt = await DatabaseHelper.instance
                                  .insert(book);
                              print("savedInt $savedInt");
                              SnackBar snackBar = const SnackBar(
                                  content: Text("Book Saved"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              setState(() {
                                _isBookSaved = true;
                              });
                            } catch (e) {
                              print("Error: $e");
                            }
                          }, child: Text(_isBookSaved ? 'Saved' : 'Save'))
                          : ElevatedButton.icon(
                          onPressed: () async {},
                          icon: const Icon(Icons.save),
                          label: const Text('Saved'))),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Description',
                    style: theme.titleMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondary)),
                    child: Text(book.description),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

FloatingActionButton _floatingButton(BuildContext context,Book book) {
  return FloatingActionButton(
    onPressed: () {
      bool itemAdded = Provider.of<AppNotifier>(context,listen: false).addCartItem(book);
      if(itemAdded){
        scaffoldMessage(context, 'Item Added into Cart');
      }
    },
    backgroundColor: LightColor.secondaryColor,
    child: Icon(Icons.shopping_basket,
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
  );
}

