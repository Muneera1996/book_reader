import 'package:book_reader/utils/Constants.dart';
import 'package:flutter/material.dart';

import '../db/database_helper.dart';
import '../models/book.dart';
import '../utils/book_details_arguments.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: DatabaseHelper.instance.readAllBooks(),
            builder: (context, snapshot) => snapshot.hasData
                ? ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Book book = snapshot.data![index];
                  // get each books fav status

                  //print("Books: ==> ${snapshot.data![index].toString()}");
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Constants.details,
                          arguments: BookDetailsArguments(
                              itemBook: book, isFromSavedScreen: true));
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(book.title),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            DatabaseHelper.instance.deleteBook(book.id);
                            setState(() {});
                          },
                        ),
                        leading: Image.network(
                          book.imageLinks['thumbnail'] ?? '',
                          fit: BoxFit.cover,
                        ),
                        subtitle: Column(
                          children: [
                            Text(book.authors.join(', ')),
                            ElevatedButton.icon(
                                onPressed: () async {
                                  // toggle the favorite flag
                                  book.isFavorite = !book.isFavorite;
                                  await DatabaseHelper.instance
                                      .toggleFavoriteStatus(
                                      book.id, book.isFavorite);
                                  //refresh th UI
                                  setState(() {});
                                },
                                icon: Icon(
                                  book.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: book.isFavorite ? Colors.red : null,
                                ),
                                label: Text((book.isFavorite)
                                    ? 'Favorite'
                                    : 'Add to Favorites'))
                          ],
                        ),
                      ),
                    ),
                  );
                })
                : const Center(child: CircularProgressIndicator())),
      ),
    );
  }

}
