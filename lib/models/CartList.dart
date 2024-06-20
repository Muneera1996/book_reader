import 'package:book_reader/models/Book.dart';


class CartList {
  static List<Book> _items = [];
  static CartList? _cartList;

  CartList._internal(); // Private constructor for singleton

  static CartList getInstance() {
    _cartList ??= CartList._internal();
    return _cartList!;
  }

  int getCartSize() {
    int items = 0;
    _items.forEach((x) {
      items += x.quantity; // Use quantity here
    });
    return items;
  }

  List<Book> getCartItems() {
    return _items;
  }

  void removeItem(String bookId) {
    _items.removeWhere((item) => item.id == bookId);
  }

  void decrementItem(String bookId) {
    for (var item in _items) {
      if (item.id == bookId) {
        print("Item found to decrement");
        // Handle quantity separately
        if (item.quantity > 1) {
          item.quantity -= 1; // Decrement quantity
        } else {
          _items.remove(item);
        }
        break;
      }
    }
  }

  bool addItem(Book book) {
    bool isItemFound = checkBookExistInCart(book.id);

    if (!isItemFound) {
      _items.add(book);
    }

    return true;
  }

  bool checkBookExistInCart(String bookId) {
    for (var item in _items) {
      if (item.id == bookId) {
        print("Item found in cart");
        item.quantity += 1; // Increment quantity if found
        return true;
      }
    }
    return false;
  }
}


