import 'package:great_places/models/user.dart';
import 'package:great_places/screens/onboarding/onboarding.dart';
import 'package:great_places/screens/home/places_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  final double screenHeight;

  Wrapper({@required this.screenHeight});

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Onboarding(
        screenHeight: widget.screenHeight,
      );
    } else {
      return PlacesListScreen();
    }
  }
}
