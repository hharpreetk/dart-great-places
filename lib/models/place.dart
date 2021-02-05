// models/place.dart

import 'dart:io';
import 'package:flutter/foundation.dart';

class Place {
  final String id;
  final String title;
  final String note;
  final double latitude;
  final double longitude;
  final String address;
  final File image;
  final DateTime dateVisited;

  Place(
      {@required this.id,
      @required this.title,
      @required this.latitude,
      @required this.longitude,
      this.address,
      @required this.image,
      this.dateVisited,
      this.note});
}
