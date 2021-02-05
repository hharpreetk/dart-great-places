import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:great_places/constants.dart';

class Logo extends StatelessWidget {
  final Color color;
  final double size;

  const Logo({
    @required this.color,
    @required this.size,
  })  : assert(color != null),
        assert(size != null);

  @override
  Widget build(BuildContext context) {
    if(color == kWhite) {
      return Image(
        image: AssetImage(kLogoWhite),
        height: size,
      );
    }
    else {
      return Image(
        image: AssetImage(kLogoBlue),
        height: size,
      );
    }
  }
}
