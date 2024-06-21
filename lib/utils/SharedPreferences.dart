import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
   static SharedPreferences? _sharedPreferences;
  static AppSharedPreferences? _appSharedPreferences;

  AppSharedPreferences();

  static Future<AppSharedPreferences> getPreferencesInstance() async {
    if (_sharedPreferences == null) {
      _appSharedPreferences = AppSharedPreferences();
      _sharedPreferences = await SharedPreferences.getInstance();
      return _appSharedPreferences!;
    }
    return _appSharedPreferences!;
  }

  String? getLanguageCode() {
    return _sharedPreferences?.getString("languageCode");
  }

  bool setLanguageCode(String languageCode) {
    _sharedPreferences?.setString("languageCode", languageCode);
    return true;
  }

  String? getDecimalPlace() {
    return _sharedPreferences?.getString("decimalPlace");
  }

  void setDecimalPlace(String decimalPlace) {
    _sharedPreferences?.setString("decimalPlace", decimalPlace);
  }

  String? getAddress() {
    return _sharedPreferences?.getString("address");
  }

  void setAddress(String address) {
    _sharedPreferences?.setString("address", address);
  }

  String? getPhoneNo() {
    return _sharedPreferences?.getString("phoneNo");
  }

  void setPhoneNo(String phoneNo) {
    _sharedPreferences?.setString("phoneNo", phoneNo);
  }

  String? getAppName() {
    return _sharedPreferences?.getString("appName");
  }

  void setAppName(String appName) {
    _sharedPreferences?.setString("appName", appName);
  }

  String? getNewProductDuration() {
    return _sharedPreferences?.getString("newProductDuration");
  }

  void setNewProductDuration(String newProductDuration) {
    _sharedPreferences?.setString("newProductDuration", newProductDuration);
  }

  String? getCurrencySymbol() {
    return _sharedPreferences?.getString("currencySymbol");
  }

  Future<bool> setCurrencySymbol(String currencySymbol) async {
    return await _sharedPreferences?.setString(
            "currencySymbol", currencySymbol) ??
        false;
  }

  String? getCurrencyCode() {
    return _sharedPreferences?.getString("currencyCode");
  }

  Future<bool> setCurrency(String currencyCode) async {
    return await _sharedPreferences?.setString("currencyCode", currencyCode) ??
        false;
  }

  String? getLanguage() {
    return _sharedPreferences?.getString("languageId");
  }

  Future<bool> setLanguage(String languageId) async {
    return await _sharedPreferences?.setString("languageId", languageId) ??
        false;
  }

  bool getLogin() {
    return _sharedPreferences?.getBool("isLogin") ?? false;
  }

  void setLogin(bool isLogin) {
    _sharedPreferences?.setBool("isLogin", isLogin);
  }

  bool getFirstTime() {
    return _sharedPreferences?.getBool("firstTime") ?? false;
  }

  void setFirstTime(bool isFirstTime) {
    _sharedPreferences?.setBool("firstTime", isFirstTime);
  }

  // Add methods for shipping address data
  String? getFirstName() {
    return _sharedPreferences?.getString("firstName");
  }

  void setFirstName(String firstName) {
    _sharedPreferences?.setString("firstName", firstName);
  }

  String? getLastName() {
    return _sharedPreferences?.getString("lastName");
  }

  void setLastName(String lastName) {
    _sharedPreferences?.setString("lastName", lastName);
  }

  String? getAddress1() {
    return _sharedPreferences?.getString("address1");
  }

  void setAddress1(String address1) {
    _sharedPreferences?.setString("address1", address1);
  }

  String? getEmail() {
    return _sharedPreferences?.getString("email");
  }

  void setEmail(String email) {
    _sharedPreferences?.setString("email", email);
  }

  String? getCity() {
    return _sharedPreferences?.getString("city");
  }

  void setCity(String city) {
    _sharedPreferences?.setString("city", city);
  }

  String? getCountry() {
    return _sharedPreferences?.getString("country");
  }

  void setCountry(String country) {
    _sharedPreferences?.setString("country", country);
  }

  String? getPostalCode() {
    return _sharedPreferences?.getString("postalCode");
  }

  void setPostalCode(String postalCode) {
    _sharedPreferences?.setString("postalCode", postalCode);
  }
}
