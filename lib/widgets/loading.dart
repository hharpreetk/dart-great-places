import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:great_places/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhite,
      child: Center(
        child: SpinKitFadingCube(
          color: kBlue,
          size: 50,
        ),
      ),
    );
  }
}
