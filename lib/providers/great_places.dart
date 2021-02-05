import 'package:flutter/foundation.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'dart:io';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  // Creates a copy of items.
  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(String pickedTitle, File pickedImage, double latitude, double longitude) async
  {

    final address = await LocationHelper.getPlaceAddress(latitude, longitude);

    final newPlace = Place(id: DateTime.now().toString(), title: pickedTitle, image: pickedImage, longitude: latitude, latitude:longitude,
    address: address,
    dateVisited: DateTime.now());

    _items.add(newPlace);
    notifyListeners();
  }

}