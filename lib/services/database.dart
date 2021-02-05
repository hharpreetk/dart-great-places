import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {

  String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference placesCollection =
      Firestore.instance.collection('places');

  Future addUserData(
      String title,
      String image,
      double placeLatitude,
      double placeLongitude,
      String address,
      String note,
      DateTime dateCreated) async {
    return await placesCollection.document(uid).collection('place').add({
      'title': title,
      'image': image,
      'latitude': placeLatitude,
      'longitude': placeLongitude,
      'note': note,
      'address': address,
      'dateCreated': dateCreated
    });
  }

  //get places stream
  Stream<QuerySnapshot> get places {
    return placesCollection.snapshots();
  }
}
