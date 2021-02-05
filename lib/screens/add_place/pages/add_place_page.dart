import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/constants.dart';
import 'package:great_places/screens/add_place/pages/map_screen.dart';
import 'package:great_places/screens/add_place/widgets/header.dart';
import 'dart:io';

// Allows images to be taken from app.
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

// Path package to merge file system paths.
import 'package:path/path.dart' as path;

// Path_Provider package for finding paths in local file system.
import 'package:path_provider/path_provider.dart' as syspaths;

import 'package:great_places/helpers/location_helper.dart';

class AddPlacePage extends StatefulWidget {
  final int selected;
  final Function selectImage;
  final TextEditingController titleHandler;
  final TextEditingController noteHandler;
  final String pickedImage;
  final Function selectUId;
  final Function savePlace;
  final Function selectPlace;

  AddPlacePage(
      {@required this.selected,
      @required this.selectImage,
      @required this.titleHandler,
      @required this.noteHandler,
      @required this.pickedImage,
      @required this.selectUId,
      @required this.savePlace,
      @required this.selectPlace})
      : assert(selected != null),
        assert(titleHandler != null),
        assert(noteHandler != null);

  @override
  _AddPlacePageState createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage>
    with TickerProviderStateMixin {
  TabController _tabController;
  int index;
  File _storedImage;
  String _previewImageUrl;
  int maxL = null;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void _showPreview(double lat, double lng) {
    final staticMapImageURL = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = staticMapImageURL;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);
      final address = await LocationHelper.getPlaceAddress(
          locData.latitude, locData.longitude);
      widget.selectPlace(locData.latitude, locData.longitude, address);
    } catch (e) {
      return;
    }
  }

  Future<void> _getUser() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    widget.selectUId(uid);
    // here you write the codes to input the data into firestore
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );

    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    final address = await LocationHelper.getPlaceAddress(
        selectedLocation.latitude, selectedLocation.longitude);
    widget.selectPlace(
        selectedLocation.latitude, selectedLocation.longitude, address);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
    _tabController = new TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }


  void _handleTabSelection() {
    setState(() {});
  }

  // Below - Using image_picker. Needs to be added to pubspec.yaml and imported above
  Future<void> _choosePicture() async {
    // Opens camera and takes picture, returns a future so async await is needed
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      // Source of where the image comes from, camera here not gallery
      maxWidth: 600, // Restricts resolution
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      // Allows the image preview below
      _storedImage = imageFile;
    });
    // Prevents error in canceling picture, breaking out since the imageFile would be null
    if (imageFile == null) {
      return;
    }
    // Begin - Write the image to local file system using above imported packages: path as path and path_provider as syspaths.
    final appDir = await syspaths
        .getApplicationDocumentsDirectory(); // Location for app data, gives a future
    final fileName = path.basename(imageFile
        .path); // basename is the name of the file name and ext and imageFile.path is the path to where the imageFile is temporarily stored
    final savedImage = await imageFile.copy(
        '${appDir.path}/$fileName'); // Returns a future and Copies the file into the path and keeps the file name. Writes the image to the path found by appDir above using getApplicationDocumentsDirectory()
    // End - Image Write
    widget.selectImage('${appDir.path}/$fileName');
  }

  Future<void> _takePicture() async {
    // Opens camera and takes picture, returns a future so async await is needed
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      // Source of where the image comes from, camera here not gallery
      maxWidth: 600, // Restricts resolution
    );
    //if image file is null don't continue
    if (imageFile == null) {
      return;
    }
    setState(() {
      // Allows the image preview below
      _storedImage = imageFile;
    });
    // Prevents error in canceling picture, breaking out since the imageFile would be null
    if (imageFile == null) {
      return;
    }
    // Begin - Write the image to local file system using above imported packages: path as path and path_provider as syspaths.
    final appDir = await syspaths
        .getApplicationDocumentsDirectory(); // Location for app data, gives a future
    final fileName = path.basename(imageFile
        .path); // basename is the name of the file name and ext and imageFile.path is the path to where the imageFile is temporarily stored
    final savedImage = await imageFile.copy(
        '${appDir.path}/$fileName'); // Returns a future and Copies the file into the path and keeps the file name. Writes the image to the path found by appDir above using getApplicationDocumentsDirectory()
    // End - Image Write
    widget.selectImage('${appDir.path}/$fileName');
  }


  @override
  Widget build(BuildContext context) {

    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
          child: SingleChildScrollView(
          reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Header(),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: widget.titleHandler,
                    textAlign: TextAlign.left,
                    cursorColor: Colors.white,
                    onChanged: (value) {},
                    style: TextStyle(color: Colors.black87, fontSize: 17),
                    decoration: InputDecoration(
                        labelText: 'Title',
                        suffix: GestureDetector(
                            onTap: () {
                              widget.titleHandler.clear();
                            },
                            child: Icon(Icons.clear))),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    topLeft: Radius.circular(12)),
                                color: kBlue),
                            height: 300.0,
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              children: [
                                Center(
                                  child: _storedImage != null
                                      ? Image.file(
                                          _storedImage,
                                          fit: BoxFit.contain,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 300,
                                        )
                                      : new FlatButton(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/photo-icon.png',
                                                height: 40,
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            _choosePicture();
                                          },
                                        ),
                                ),
                                Center(
                                  child: _storedImage != null
                                      ? Image.file(
                                          _storedImage,
                                          fit: BoxFit.contain,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 300,
                                        )
                                      : new FlatButton(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/camera-icon.png',
                                                height: 40,
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            _takePicture();
                                          },
                                        ),
                                ),
                                Center(
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: kWhite,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12)),
                                            border: Border.all(color: kGrey)),
                                        height: 300,
                                        width: double.infinity,
                                        child: _previewImageUrl == null
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12),
                                                    topRight:
                                                        Radius.circular(12)),
                                                child: GoogleMap(
                                                  initialCameraPosition:
                                                      CameraPosition(
                                                          target:
                                                              LatLng(0.0, 0.0),
                                                          zoom: 10),
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12),
                                                    topRight:
                                                        Radius.circular(12)),
                                                child: Image.network(
                                                  _previewImageUrl,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                ),
                                              ),
                                      ),
                                      Positioned(
                                        child: Column(
                                          children: [
                                            FloatingActionButton(
                                              heroTag: null,
                                              elevation: 1,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12))),
                                              child: Icon(
                                                Icons.location_on,
                                                color: kWhite,
                                              ),
                                              onPressed: () {
                                                _getCurrentUserLocation();
                                              },
                                              backgroundColor: kBlue,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            FloatingActionButton(
                                              heroTag: null,
                                              elevation: 1,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12))),
                                              child: Icon(
                                                Icons.map,
                                                color: kWhite,
                                              ),
                                              onPressed: () {
                                                _selectOnMap();
                                              },
                                              backgroundColor: kBlue,
                                            ),
                                          ],
                                        ),
                                        right: 15,
                                        top: 25,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15, top: 5, right: 10),
                                    decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12)),
                                        border: Border.all(color: kGrey)),
                                    height: 300,
                                    width: double.infinity,
                                  child: SingleChildScrollView(
                                    child: SafeArea(
                                      child: Focus(
                                        onFocusChange: (hasFocus){
                                          if(hasFocus){
                                            setState(() {
                                              maxL = 8;
                                            });
                                          }
                                          else{
                                            maxL = null;
                                          }
                                        },
                                        child: TextField(
                                          style: TextStyle(height: 1.3, fontSize: 17),
                                          textInputAction: TextInputAction.go,
                                          controller: widget.noteHandler,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Enter your note...',
                                          ),
                                          maxLines:
                                              maxL, // when user presses enter it will adapt to it
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: TabBar(
                            tabs: [
                              Tab(
                                icon: _tabController.index == 0
                                    ? new Image.asset(
                                        "assets/images/image-enabled.png")
                                    : new Image.asset(
                                        'assets/images/image-disabled.png'),
                              ),
                              Tab(
                                icon: _tabController.index == 1
                                    ? new Image.asset(
                                        "assets/images/camera-enabled.png")
                                    : new Image.asset(
                                        'assets/images/camera-disabled.png'),
                              ),
                              Tab(
                                icon: _tabController.index == 2
                                    ? new Image.asset(
                                        "assets/images/location-enabled.png")
                                    : new Image.asset(
                                        'assets/images/location-disabled.png'),
                              ),
                              Tab(
                                icon: _tabController.index == 3
                                    ? new Image.asset(
                                        "assets/images/note-enabled.png")
                                    : new Image.asset(
                                        'assets/images/note-disabled.png'),
                              ),
                            ],
                            controller: _tabController,
                            indicatorColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(60))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add Place',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.arrow_forward,
                size: 22,
              ),
            ],
          ),
          onPressed: () {
            widget.savePlace();
          },
          padding: EdgeInsets.all(19),
          color: kBlue,
          textColor: kWhite,
          elevation: 0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        )
      ],
    );
  }
}
