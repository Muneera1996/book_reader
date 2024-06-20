import 'package:badges/badges.dart';
import 'package:book_reader/components/app_badge_icon.dart';
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
      title: Text(title),
      actions: <Widget>[
        appBadgeIcons(context,-17),
        const SizedBox(width: 15,)
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}




class AppBarIcons extends StatelessWidget {
  final Icon icon;
  final Function onPress;

  const AppBarIcons({super.key,
    required this.icon,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPress,
      icon: icon,
    );
  }
}
