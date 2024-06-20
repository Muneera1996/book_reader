import 'package:book_reader/db/database_helper.dart';

import '../models/book.dart';

class CartList {
  static final CartList _instance = CartList._internal();
  final List<Book> _cartItems = [];

  CartList._internal();

  static CartList getInstance() => _instance;

  bool checkBookExistInCart(String productId) {
    return _cartItems.any((book) => book.id == productId);
  }

  bool addItem(Book book) {
    if (checkBookExistInCart(book.id)) {
      return false;
    }
    book.quantity = 1;
    _cartItems.add(book);
    return true;
  }
  void incrementItem(String productId) {
    final index = _cartItems.indexWhere((book) => book.id == productId);
    if (index != -1) {
      _cartItems[index].quantity++;
    }
  }
  //
  // Future<void> decrementItem(String productId) async {
  //   final index = _cartItems.indexWhere((book) => book.id == productId);
  //   if (index != -1) {
  //     _cartItems[index].quantity--;
  //     if (_cartItems[index].quantity <= 0) {
  //      await deleteCartItem(productId);
  //     } else {
  //       await saveCartToDatabase();
  //     }
  //   }
  // }

  Future<void> decrementItem(String productId) async {
    final index = _cartItems.indexWhere((book) => book.id == productId);
    if (index != -1) {
      if (_cartItems[index].quantity > 0) {
        _cartItems[index].quantity--;
        if (_cartItems[index].quantity == 0) {
          await deleteCartItem(productId);
        } else {
          await saveCartToDatabase();
        }
      }
    }
  }


  int getCartSize() {
    return _cartItems.length;
  }


  List<Book> getCartItems() {
    return _cartItems;
  }

  Future<void> deleteCartItem(String id) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.deleteCartBook(id);
    return;
  }

  Future<void> saveCartToDatabase() async {
    final dbHelper = DatabaseHelper.instance;
    for (var book in _cartItems) {
      await dbHelper.insert(book);
    }
  }

  Future<void> loadCartFromDatabase() async {
    final dbHelper = DatabaseHelper.instance;
    _cartItems.clear();
    _cartItems.addAll(await dbHelper.readAllCartBooks());
  }
}
