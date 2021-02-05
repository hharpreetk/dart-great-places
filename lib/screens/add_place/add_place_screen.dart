import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:great_places/constants.dart';
import 'package:great_places/screens/home/places_list_screen.dart';
import 'package:great_places/services/database.dart';
import './pages/add_place_page.dart';

class AddPlaceScreen extends StatefulWidget {
  final double screenHeight;

  const AddPlaceScreen({
    @required this.screenHeight,
  }) : assert(screenHeight != null);

  @override
  _AddPlaceScreen createState() => _AddPlaceScreen();
}

class _AddPlaceScreen extends State<AddPlaceScreen>
    with TickerProviderStateMixin {
  int selected = 0;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  String _pickedImage;
  String _uid;
  double _placeLatitude;
  double _placeLongitude;
  String _address;

  @override
  void initState() {
    super.initState();
  }

  void selectedChanged(newSelected) {
    setState(() {
      selected = newSelected;
    });
  }

  void _selectImage(String pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng, String address) {
    _placeLatitude = lat;
    _placeLongitude = lng;
    _address = address;
  }

  void _selectUId(String uid){
    _uid = uid;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _getPage() {
    return AddPlacePage(
        selected: selected,
        selectImage: _selectImage,
        titleHandler: _titleController,
        noteHandler: _noteController,
        pickedImage: _pickedImage,
        selectUId: _selectUId,
        savePlace: _savePlace,
        selectPlace: _selectPlace);
  }

  Future _savePlace() async {
    if (_titleController.text.isEmpty) {
      showAlertDialog(context, 'Invalid Title', "Please enter a title.");
      return;
    } else if (_pickedImage == null) {
      showAlertDialog(context, 'No Picture Found', "Please upload a picture.");
      return;
    } else if (_placeLongitude == null || _placeLatitude == null) {
      showAlertDialog(context, 'No Location Found', "Please pick a location.");
      return;
    }
    //Provider.of<GreatPlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage, _placeLatitude, _placeLongitude);

    var result = await DatabaseService(uid: _uid).addUserData(
        _titleController.text,
        _pickedImage,
        _placeLatitude,
        _placeLongitude,
        _address,
        _noteController.text,
        DateTime.now());

    if(result is String){
      showAlertDialog(context, 'Error', "Could not add place.");
    }
    else{
      Navigator.of(context).pop();
    }
  }

  showAlertDialog(BuildContext context, String title, String content) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(fontSize: 18),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: kPaddingS),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: _getPage(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
