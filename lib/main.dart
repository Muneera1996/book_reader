import 'package:book_reader/network/network.dart';
import 'package:book_reader/pages/book_detail.dart';
import 'package:book_reader/pages/fav_screen.dart';
import 'package:book_reader/pages/home_screen.dart';
import 'package:book_reader/pages/saved_screen.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
        initialRoute: '/',
        routes: {
          '/home': (context) => const HomeScreen(),
          '/saved': (context) => const SavedScreen(),
          '/favorites': (context) => const FavoritesScreen(),
          '/details': (context) => const BookDetailsScreen(),
        },
      home: const MyHome()
    );
  }
}
class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _currentIndex  = 0;
  final List<Widget> screens = [
    HomeScreen(),
    SavedScreen(),
    FavoritesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('A.Reader'),
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        currentIndex: _currentIndex,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Save'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite')
      ],
        selectedItemColor: Theme.of(context).colorScheme.surfaceVariant,
        unselectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: (value){
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}



