import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:great_places/screens/add_place/widgets/menu_action_icon_container.dart';
import 'package:great_places/screens/detail/widgets/show_map.dart';
import 'package:great_places/widgets/loading.dart';
import '../../constants.dart';

class PlaceDetailScreen extends StatefulWidget {
  String docId;

  PlaceDetailScreen({
    @required this.docId,
  }) : assert(docId != null);

  @override
  _PlaceDetailScreenState createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  static const routename = '/place-detail';
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
   /* Future _deletePlace(String userId, String placeId) async{
     final doc = Firestore.instance.collection('places').document(userId).collection('place').document(placeId);
     return await doc.delete();
    }*/

    return Scaffold(
      backgroundColor: kWhite,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
              child: Padding(
                padding: const EdgeInsets.only(top: kPaddingS),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: MenuIconContainer(
                          icon: Icons.arrow_back, padding: 12),
                    ),
                    new GestureDetector(
                      onTap: () {
                       /* _deletePlace(userId, widget.docId);*/
                      },
                      child: MenuIconContainer(
                          icon: Icons.delete_outline, padding: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: new StreamBuilder(
                  stream: Firestore.instance
                      .collection("places")
                      .document(userId)
                      .collection('place')
                      .document(widget.docId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Loading();
                    }
                    var currentPlace = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.file(
                                File(currentPlace["image"]),
                              ),
                              Positioned(
                                child: FloatingActionButton(
                                  heroTag: null,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Icon(
                                    Icons.location_on,
                                    color: kWhite,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (ctx) => ShowMap(
                                            initialLatitude: double.parse(currentPlace['latitude'].toString()),
                                            initialLongitude: double.parse(currentPlace['longitude'].toString()),
                                            isSelecting: false,
                                          ),
                                        )
                                    );
                                  },
                                  backgroundColor: kLightBlue,
                                ),
                                right: 10,
                                bottom: 10,
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(currentPlace['title'],
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    currentPlace['address'],
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 9,
                                  ),
                                  Text(
                                    currentPlace['note'],
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
