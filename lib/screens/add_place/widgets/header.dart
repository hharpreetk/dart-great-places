import 'package:flutter/material.dart';
import 'menu_action_icon_container.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: MenuIconContainer(icon: Icons.arrow_back, padding: 12),
        ),

      ],
    );
  }
}
