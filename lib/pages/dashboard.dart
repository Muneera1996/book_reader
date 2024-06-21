import 'package:book_reader/components/custom_app_bar.dart';
import 'package:book_reader/pages/fav_screen.dart';
import 'package:book_reader/pages/home_screen.dart';
import 'package:book_reader/pages/saved_screen.dart';
import 'package:book_reader/themes/light_color.dart';
import 'package:book_reader/utils/Constants.dart';
import 'package:book_reader/utils/SharedPreferences.dart';
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

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // Clear the database
                await Provider.of<AppNotifier>(context, listen: false).clearDatabase();

                // Clear shared preferences
                var prefs = await AppSharedPreferences.getPreferencesInstance();
                await prefs.clearSharedPreferences();

                // Close the dialog
                Navigator.of(context).pop();

                // Navigate to the sign-in screen and remove all previous routes

                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushNamedAndRemoveUntil(context, Constants.signIn, (route) => false);
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'A.Reader',),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                'Welcome to Book Reader!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
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
