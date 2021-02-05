import 'package:flutter/material.dart';

import 'package:great_places/screens/onboarding/widgets/text_column.dart';

class EducationTextColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextColumn(
      title: 'Save Location',
      text: 'Store photos together with location based on GPS or by pointing on the map.',
    );
  }
}
