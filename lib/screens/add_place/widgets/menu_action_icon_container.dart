import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:great_places/constants.dart';

class MenuIconContainer extends StatelessWidget {
  final IconData icon;
  final double padding;

  const MenuIconContainer({
    @required this.icon,
    @required this.padding,
  })  : assert(icon != null),
        assert(padding != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: kBlue,
       borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Icon(
        icon,
        size: 25.0,
        color: kWhite,
      ),
    );
  }
}
