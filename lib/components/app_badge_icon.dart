import 'package:book_reader/models/CartList.dart';
import 'package:book_reader/notifiers/AppNotifier.dart';
import 'package:book_reader/pages/shopping_cart_screen.dart';
import 'package:book_reader/pages/empty_screen.dart';
import 'package:book_reader/themes/light_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

AppBadgeIcons appBadgeIcons(context, double topPosition) {
  return AppBadgeIcons(
    icon: FontAwesomeIcons.cartPlus,
    topPosition: topPosition,
  );
}

class AppBadgeIcons extends StatelessWidget {
  final IconData icon;
  final double topPosition;

  const AppBadgeIcons({
    super.key,
    required this.icon,
    required this.topPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(builder: (context, value, child) {
      return InkWell(
        onTap: () {
          if (CartList.getInstance().getCartSize() == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const EmptyCartScreen()));
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ShoppingCartScreen()),
            );
          }
        },
        child: badges.Badge(
          position: badges.BadgePosition.topStart(top: topPosition, start: 5),
          showBadge: true,
          badgeContent: Text(
            value.getCartSize().toString(),
            style: const TextStyle(color: Colors.white),
          ),
          child: Icon(icon),
        ),
      );
    });
  }
}
