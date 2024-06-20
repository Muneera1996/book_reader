import 'package:book_reader/pages/app_sign_in.dart';
import 'package:book_reader/pages/dashboard.dart';
import 'package:book_reader/utils/SharedPreferences.dart';
import 'package:book_reader/utils/images.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // SharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();
    performDelayedAction();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Image.asset(kAppLogo,
        height: double.infinity,
        width: double.infinity,
      )
    );
  }

  void checkFirstTime() async {
    AppSharedPreferences sharedPreferences = await AppSharedPreferences.getPreferencesInstance();
    bool firstTime = sharedPreferences.getFirstTime() ?? true;

    sharedPreferences.setCurrency("Euro");
    sharedPreferences.setCurrencySymbol("\€");

    if(firstTime){
      Navigator.push(context, MaterialPageRoute(builder: (context) => AppSignIn()));
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
    }

  }
  Future<void> performDelayedAction() async {
    await Future.delayed(Duration(seconds: 2));
    // Perform your action here
    print("This message is displayed after a 2-second delay.");
    checkFirstTime();

  }
}




