import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:great_places/screens/add_place/add_place_screen.dart';
import 'package:great_places/constants.dart';
import 'package:great_places/screens/add_place/widgets/menu_action_icon_container.dart';


class Header extends StatelessWidget {
  final double screenHeight;
  final scaffoldkey;

  Header({@required this.screenHeight,
  @required this.scaffoldkey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new GestureDetector(
            child: Image.asset('assets/images/menu.png'),
            onTap: () {
              scaffoldkey.currentState.openDrawer();
            },
          ),
          new GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddPlaceScreen(
                    screenHeight: screenHeight,
                  ),
                ),
              );
            },
            child: MenuIconContainer(icon: Icons.add, padding: 12),
          ),
        ],
      ),
    );
  }
}
