import 'package:book_reader/themes/light_color.dart';
import 'package:book_reader/utils/images.dart';
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
          child:
           Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(kEmptyCart),
            const Text("Cart is Empty!"),
            SizedBox(
              height:
              MediaQuery.of(context).size.height * 0.1,
            )
          ],
        )
        ),
      ),
    );
  }
}
