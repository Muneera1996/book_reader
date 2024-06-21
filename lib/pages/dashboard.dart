import 'package:book_reader/components/custom_app_bar.dart';
import 'package:book_reader/pages/fav_screen.dart';
import 'package:book_reader/pages/home_screen.dart';
import 'package:book_reader/pages/saved_screen.dart';
import 'package:book_reader/themes/light_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifiers/AppNotifier.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex  = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const SavedScreen(),
    const FavoritesScreen()
  ];

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    await Provider.of<AppNotifier>(context, listen: false)
        .loadCartFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'A.Reader',),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Save'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite')
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: LightColor.primaryLightColor,
        onTap: (value){
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}