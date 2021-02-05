import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:great_places/screens/home/widgets/list_tile.dart';
import 'package:provider/provider.dart';

class PlacesList extends StatefulWidget {

  @override
  _PlacesListState createState() => _PlacesListState();
}

class _PlacesListState extends State<PlacesList> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userId;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    final FirebaseUser user = await _auth.currentUser();
    userId = user.uid;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: Firestore.instance
            .collection("places")
            .document(userId)
            .collection('place')
            .snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Text(
                      'got no places yet',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (ctx, i) {
                    DocumentSnapshot place = snapshot.data.documents[i];
                    return ListItem(
                       documentId: place.documentID,
                        placeImage: File(place['image']),
                        placeTitle: place['title'],
                        address: place['address'],
                        date: place['dateCreated'].toDate());
                  },
                );
        });
  }
}
