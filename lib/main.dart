import 'package:book_reader/network/network.dart';
import 'package:book_reader/notifiers/AppNotifier.dart';
import 'package:book_reader/pages/app_sign_in.dart';
import 'package:book_reader/pages/book_detail.dart';
import 'package:book_reader/pages/dashboard.dart';
import 'package:book_reader/pages/fav_screen.dart';
import 'package:book_reader/pages/home_screen.dart';
import 'package:book_reader/pages/saved_screen.dart';
import 'package:book_reader/pages/splashScreen.dart';
import 'package:book_reader/themes/theme.dart';
import 'package:book_reader/utils/Constants.dart';
import 'package:book_reader/utils/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  AppSharedPreferences? sharedPreferences;



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          Constants.home : (context) => const HomeScreen(),
          Constants.saved: (context) => const SavedScreen(),
          Constants.favorites : (context) => const FavoritesScreen(),
          Constants.details : (context) => const BookDetailsScreen(),
          Constants.dashboard : (context) => const Dashboard(),
        },
      home: SplashScreen()
    );
  }
}






