import 'package:book_reader/models/Book.dart';
import 'package:book_reader/models/CartList.dart';
import 'package:book_reader/utils/SharedPreferences.dart';
import 'package:flutter/foundation.dart';

class AppNotifier extends ChangeNotifier {
  static final AppNotifier appNotifier = AppNotifier._internal();
  late AppSharedPreferences appSharedPreferences;

  AppNotifier._internal() {
    print('start App');
    AppSharedPreferences.getPreferencesInstance().then((value) {
      appSharedPreferences = value;
    });
  }

  factory AppNotifier() => appNotifier;

  bool isUserLogin() {
    bool result = appSharedPreferences.getLogin();
    return result;
  }
  void setUserLogin(bool login) {
    appSharedPreferences.setLogin(login);
    notifyListeners();
  }

  bool incrementCartItem(String productId) {
    bool result = CartList.getInstance().checkBookExistInCart(productId);
    notifyListeners();
    return result;
  }

  bool addCartItem(Book book) {
    bool result = CartList.getInstance().addItem(book);
    notifyListeners();
    return result;
  }

  decrementCartItem(String productId) {
    CartList.getInstance().decrementItem(productId);
    notifyListeners();
  }

  int getCartSize() {
    int size = CartList.getInstance().getCartSize();
    print("Size ${size}");
    return size;
  }

  void removeCartItem(String productId) {
    CartList.getInstance().removeItem(productId);
    notifyListeners();
  }
}
