import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:great_places/constants.dart';
import 'package:great_places/screens/home/widgets/header.dart';
import 'package:great_places/screens/home/widgets/placeList.dart';
import 'package:great_places/screens/navigation/appDrawer.dart';
import 'package:great_places/services/database.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatefulWidget {

  @override
  _PlacesListScreenState createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().places,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(),
        backgroundColor: kWhite,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 35,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Header(screenHeight: screenHeight, scaffoldkey: _scaffoldKey),
              Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: PlacesList(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
