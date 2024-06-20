import 'package:shared_preferences/shared_preferences.dart';


class AppSharedPreferences {
  static SharedPreferences? sharedPreferences;
  static AppSharedPreferences? _appSharedPreferences;

  AppSharedPreferences();

  static Future<AppSharedPreferences> getPreferencesInstance() async {
    if (sharedPreferences == null) {
      _appSharedPreferences = AppSharedPreferences();
      sharedPreferences = await SharedPreferences.getInstance();
      return _appSharedPreferences!;
    }
    return _appSharedPreferences!;
  }

  String? getLanguageCode() {
    return sharedPreferences?.getString("languageCode");
  }

  bool setLanguageCode(String languageCode) {
    sharedPreferences?.setString("languageCode", languageCode);
    return true;
  }

  String? getDecimalPlace() {
    return sharedPreferences?.getString("decimalPlace");
  }

  void setDecimalPlace(String decimalPlace) {
    sharedPreferences?.setString("decimalPlace", decimalPlace);
  }

  String? getAddress() {
    return sharedPreferences?.getString("address");
  }

  void setAddress(String address) {
    sharedPreferences?.setString("address", address);
  }

  String? getPhoneNo() {
    return sharedPreferences?.getString("phoneNo");
  }

  void setPhoneNo(String phoneNo) {
    sharedPreferences?.setString("phoneNo", phoneNo);
  }

  String? getContactUsEmail() {
    return sharedPreferences?.getString("contactUsEmail");
  }

  void setContactUsEmail(String contactUsEmail) {
    sharedPreferences?.setString("contactUsEmail", contactUsEmail);
  }

  String? getFcmAndroidSenderId() {
    return sharedPreferences?.getString("fcmAndroidSenderId");
  }

  void setFcmAndroidSenderId(String fcmAndroidSenderId) {
    sharedPreferences?.setString("fcmAndroidSenderId", fcmAndroidSenderId);
  }

  String? getAppName() {
    return sharedPreferences?.getString("appName");
  }

  void setAppName(String appName) {
    sharedPreferences?.setString("appName", appName);
  }

  String? getNewProductDuration() {
    return sharedPreferences?.getString("newProductDuration");
  }

  void setNewProductDuration(String newProductDuration) {
    sharedPreferences?.setString("newProductDuration", newProductDuration);
  }

  String? getCurrencySymbol() {
    return sharedPreferences?.getString("currencySymbol");
  }

  Future<bool> setCurrencySymbol(String currencySymbol) async {
    return await sharedPreferences?.setString("currencySymbol", currencySymbol) ?? false;
  }

  String? getCurrencyCode() {
    return sharedPreferences?.getString("currencyCode");
  }

  Future<bool> setCurrency(String currencyCode) async {
    return await sharedPreferences?.setString("currencyCode", currencyCode) ?? false;
  }

  String? getLanguage() {
    return sharedPreferences?.getString("languageId");
  }

  Future<bool> setLanguage(String languageId) async {
    return await sharedPreferences?.setString("languageId", languageId) ?? false;
  }

  bool getLogin() {
    return sharedPreferences?.getBool("isLogin") ?? false;
  }

  void setLogin(bool isLogin) {
    sharedPreferences?.setBool("isLogin", isLogin);
  }

  bool getFirstTime() {
    return sharedPreferences?.getBool("firstTime") ?? false;
  }

  void setFirstTime(bool isFirstTime) {
    sharedPreferences?.setBool("firstTime", isFirstTime);
  }
}

