import 'package:flutter/material.dart';
import 'package:great_places/screens/home/places_list_screen.dart';
import 'package:great_places/screens/login/login.dart';
import 'package:great_places/screens/signup/signup.dart';
import 'package:great_places/services/auth.dart';
import 'package:provider/provider.dart';
import './providers/great_places.dart';
import 'models/user.dart';
import 'screens/onboarding/onboarding.dart';
import 'screens/add_place/add_place_screen.dart';
import 'package:great_places/screens/wrapper.dart';

void main() {
  runApp(MyApp());
}

class ScreenHeight {
  static double size;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: //PlacesListScreen(),

        Builder(
          builder: (BuildContext context) {
            ScreenHeight.size = MediaQuery.of(context).size.height;
            return Wrapper(
              screenHeight: ScreenHeight.size ,
            );
          },
        ),
        routes: {
          '/login':(context) => Login(screenHeight: ScreenHeight.size),
          '/signup': (context) => SignUp(screenHeight: ScreenHeight.size)
        },
      ),
    );
  }
}

