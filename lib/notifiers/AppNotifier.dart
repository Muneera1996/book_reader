import 'package:book_reader/db/database_helper.dart';

import '../models/book.dart';
import 'package:book_reader/models/CartList.dart';
import 'package:book_reader/utils/SharedPreferences.dart';
import 'package:flutter/foundation.dart';


class AppNotifier extends ChangeNotifier {
  static final AppNotifier appNotifier = AppNotifier._internal();
  late AppSharedPreferences appSharedPreferences;
  late DatabaseHelper databaseHelper;

  AppNotifier._internal() {
    AppSharedPreferences.getPreferencesInstance().then((value) {
      appSharedPreferences = value;
    });
    databaseHelper = DatabaseHelper.instance;
  }

  factory AppNotifier() => appNotifier;

  bool isUserLogin() {
    bool result = appSharedPreferences.getLogin();
    return result;
  }

  void setUserLogin(String email,bool login) {
    appSharedPreferences.setLogin(login);
    appSharedPreferences.setEmail(email);
    notifyListeners();
  }

   incrementCartItem(String productId) {
    CartList.getInstance().incrementItem(productId);
    _saveCartToDatabase();
  }

  Future<void> removeCartItem(String productId) async {
    await CartList.getInstance().deleteCartItem(productId);
    loadCartFromDatabase();

  }

  Future<void> decrementCartItem(String productId) async {
    await CartList.getInstance().decrementItem(productId);
    loadCartFromDatabase();
  }


  bool addCartItem(Book book) {
    bool result = CartList.getInstance().addItem(book);
    _saveCartToDatabase();
    return result;
  }



  int getCartSize() {
    int size = CartList.getInstance().getCartSize();
    print("Size ${size}");
    return size;
  }

  Future<void> _saveCartToDatabase() async {
    await CartList.getInstance().saveCartToDatabase();
    notifyListeners();
  }

  Future<void> loadCartFromDatabase() async {
    await CartList.getInstance().loadCartFromDatabase();
    notifyListeners();
  }
}

