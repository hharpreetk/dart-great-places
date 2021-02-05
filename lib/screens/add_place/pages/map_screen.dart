import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/constants.dart';

class MapScreen extends StatefulWidget {
  final bool isSelecting;
  final double initialLatitude;
  final double initialLongitude;

  MapScreen({
    this.initialLatitude = 37.4220,
    this.initialLongitude = -122.0840,
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          overflow: Overflow.clip,
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                  target:
                      LatLng(widget.initialLatitude, widget.initialLongitude),
                  zoom: 5),
              onTap: widget.isSelecting ? _selectLocation : null,
              markers: _pickedLocation == null
                  ? null
                  : {
                      Marker(
                          markerId: MarkerId('m1'), position: _pickedLocation),
                    },
            ),
            Positioned(
              child: FloatingActionButton(
                heroTag: null,
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Icon(
                  Icons.close,
                  color: kWhite,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: kBlue,
              ),
              left: 15,
              top: 25,
            ),
            widget.isSelecting
                ? Positioned(
                    child: FloatingActionButton(
                      heroTag: null,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Icon(
                        Icons.check,
                        color: kWhite,
                      ),
                      onPressed: _pickedLocation == null
                          ? null
                          : () {
                              Navigator.of(context).pop(_pickedLocation);
                            },
                      backgroundColor: kBlue,
                    ),
                    right: 15,
                    top: 25,
                  )
                : null,
          ],
        ),
      ),
    );
  }
}
