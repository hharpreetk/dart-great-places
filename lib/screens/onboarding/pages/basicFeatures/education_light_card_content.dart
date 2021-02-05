import 'package:flutter/material.dart';

import 'package:great_places/constants.dart';
import 'package:great_places/screens/onboarding/widgets/icon_container.dart';

class EducationLightCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconContainer(
          icon: Icons.photo,
          padding: kPaddingS,
        ),
        IconContainer(
          icon: Icons.location_on,
          padding: kPaddingM,
        ),
        IconContainer(
          icon: Icons.map,
          padding: kPaddingS,
        ),
      ],
    );
  }
}
