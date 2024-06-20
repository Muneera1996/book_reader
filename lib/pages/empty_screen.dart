import 'package:book_reader/themes/light_color.dart';
import 'package:flutter/material.dart';

class EmptyCartScreen extends StatefulWidget {
  const EmptyCartScreen({super.key});

  @override
  _EmptyCartScreenState createState() =>
      _EmptyCartScreenState();
}

class _EmptyCartScreenState extends State<EmptyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
                child: Container(
                  color: Color(0xFFFFFFFF),
                ),
              ),
              Container(
                width: double.infinity,
                height: 250,
                child: Image.asset(
                  "assets/images/empty_shopping_cart.png",
                  height: 250,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 40,
                child: Container(
                  color: Colors.white,
                ),
              ),
              Container(
                width: double.infinity,

                child: const Text(
                  "You haven't anything in your cart",
                  style: TextStyle(
                    color: LightColor.secondaryColor,
                    fontFamily: 'Roboto-Light.ttf',
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
