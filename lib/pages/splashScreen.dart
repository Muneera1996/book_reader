import 'package:book_reader/notifiers/AppNotifier.dart';
import 'package:book_reader/pages/app_sign_in.dart';
import 'package:book_reader/pages/dashboard.dart';
import 'package:book_reader/themes/light_color.dart';
import 'package:book_reader/utils/Constants.dart';
import 'package:book_reader/utils/SharedPreferences.dart';
import 'package:book_reader/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  AppSharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();
    AppSharedPreferences.getPreferencesInstance().then((value) {
      setState(() {
        sharedPreferences = value;
      });
    });
    performDelayedAction();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
    child:  Consumer<AppNotifier>(builder: (context, value, child) => Container(
        color: LightColor.background,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset(kAppLogo),
        ),
      ) )
        );
  }

  void checkFirstTime() async {
    bool userLogin = sharedPreferences?.getLogin() ?? false;

    if(userLogin){
      Navigator.pushReplacementNamed(context, Constants.dashboard);
    }
    else{
      Navigator.pushReplacementNamed(context, Constants.signIn);
    }

  }
  Future<void> performDelayedAction() async {
    await Future.delayed(Duration(seconds: 2));
    // Perform your action here
    print("This message is displayed after a 2-second delay.");
    checkFirstTime();

  }
}




