import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/book.dart';

class DatabaseHelper {
  static const _databaseName = 'book_database.db';
  static const _databaseVersion = 1;
  static const _tableName = 'books';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        authors TEXT NOT NULL,
        favorite INTEGER DEFAULT 0,
        publisher TEXT,
        publishedDate TEXT,
        description TEXT,
        industryIdentifiers TEXT,
        pageCount INTEGER,
        language TEXT,
        imageLinks TEXT,
        previewLink TEXT,
        infoLink TEXT,
        quantity INTEGER DEFAULT 0,
        save INTEGER DEFAULT 0
      )
    ''');
  }

  Future<int> insert(Book book) async {
    Database db = await instance.database;
    return await db.insert(
      _tableName,
      book.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Book>> readAllBooks() async {
    Database db = await instance.database;
    var books = await db.query(_tableName);
    return books.isNotEmpty
        ? books.map((bookData) => Book.fromJsonDatabase(bookData)).toList()
        : [];
  }

  Future<List<Book>> readAllSavedBooks() async {
    Database db = await instance.database;
    var books = await db.query(
      _tableName,
      where: 'save == 1', // Adding WHERE clause to filter books with quantity > 0
    );
    return books.isNotEmpty
        ? books.map((bookData) => Book.fromJsonDatabase(bookData)).toList()
        : [];
  }

  Future<List<Book>> readAllCartBooks() async {
    Database db = await instance.database;
    var books = await db.query(
      _tableName,
      where: 'quantity > 0', // Adding WHERE clause to filter books with quantity > 0
    );
    return books.isNotEmpty
        ? books.map((bookData) => Book.fromJsonDatabase(bookData)).toList()
        : [];
  }


  Future<int> toggleFavoriteStatus(String id, bool isFavorite) async {
    Database db = await instance.database;
    return await db.update(_tableName, {'favorite': isFavorite ? 1 : 0},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCartBook(String id) async {
    Database db = await instance.database;
    var book = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);

    if (book.isNotEmpty) {
      var currentBook = Book.fromJsonDatabase(book.first);

      if (currentBook.save == 0) {
        // Delete the entity if save is 0
        return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
      } else {
        // Set quantity to 0 if save is 1
        return await db.update(_tableName, {'quantity': 0}, where: 'id = ?', whereArgs: [id]);
      }
    }
    return 0; // Return 0 if no book with the given id is found

}

  Future<int> deleteSavedBook(String id) async {
    Database db = await instance.database;
    var book = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);

    if (book.isNotEmpty) {
      var currentBook = Book.fromJsonDatabase(book.first);

      if (currentBook.quantity <= 0) {
        // Delete the book if quantity is 0 or less
        return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
      } else {
        // Otherwise, set save to 0
        return await db.update(_tableName, {'save': 0}, where: 'id = ?', whereArgs: [id]);
      }
    }

    return 0; // Return 0 if no book with the given id is found
  }

  Future<List<Book>> getFavorites() async {
    Database db = await instance.database;
    var favBooks =
    await db.query(_tableName, where: 'favorite = ?', whereArgs: [1]);

    return favBooks.isNotEmpty
        ? favBooks.map((bookData) => Book.fromJsonDatabase(bookData)).toList()
        : [];
  }

  Future<bool> bookExists(String id) async {
    Database db = await instance.database;
    var result = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }

  Future<void> checkout() async {
    Database db = await instance.database;
    await db.transaction((txn) async {
      await txn.delete(_tableName, where: 'save = ?', whereArgs: [0]);
      await txn.update(_tableName, {'quantity': 0}, where: 'save = ?', whereArgs: [1]);
    });
  }

  Future<void> clearDatabase() async {
    Database db = await instance.database;
    await db.delete(_tableName);
  }
}
