import 'package:book_reader/network/network.dart';
import 'package:book_reader/pages/AppSignIn.dart';
import 'package:book_reader/pages/book_detail.dart';
import 'package:book_reader/pages/dashboard.dart';
import 'package:book_reader/pages/fav_screen.dart';
import 'package:book_reader/pages/home_screen.dart';
import 'package:book_reader/pages/saved_screen.dart';
import 'package:book_reader/themes/theme.dart';
import 'package:book_reader/utils/Constants.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: AppSignIn()
    );
  }
}




