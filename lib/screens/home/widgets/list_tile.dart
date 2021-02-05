import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:great_places/screens/detail/places_detail_screen.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class ListItem extends StatelessWidget {
  final String placeTitle;
  final DateTime date;
  final String documentId;
  final File placeImage;
  final String address;

  const ListItem({
    @required this.placeTitle,
    @required this.date,
    @required this.address,
    @required this.documentId,
    @required this.placeImage,
  })  : assert(placeTitle != null),
        assert(date != null),
        assert(placeImage != null),
        assert(documentId != null),
        assert(address != null);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(date);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // add this
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                child: Image.file(placeImage,
                    // width: 300,
                    height: 200,
                    fit: BoxFit.cover),
              ),
              ListTile(
                title: Text('${placeTitle}, ${address}'),
                subtitle: Text('Created on ${formattedDate}'),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaceDetailScreen(
                docId: documentId,
              ),
            ),
          );
        },
      ),
    );
  }
}
