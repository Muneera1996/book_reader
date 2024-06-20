import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  CustomAppBar({required this.title, this.height = kToolbarHeight});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Image.asset(
        "assets/images/logo_header.png",
        width: 120,
        height: 120,
      ),
      actions: <Widget>[
        // AppBarIcons(
        //   icon: const Icon(
        //     FontAwesomeIcons.search,
        //   ),
        //   onPress: () {
        //     // Navigator.push(
        //     //   context,
        //     //   MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
        //     // );
        //   },
        // ),
        // appBadgeIcons(context,-1),
        SizedBox(width: 15,)
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}




class AppBarIcons extends StatelessWidget {
  final Icon icon;
  final Function onPress;

  const AppBarIcons({
    required Key key,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPress,
      icon: icon,
    );
  }
}
