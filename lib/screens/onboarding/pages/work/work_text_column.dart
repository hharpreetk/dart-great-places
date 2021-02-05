import 'package:flutter/material.dart';

import 'package:great_places/screens/onboarding/widgets/text_column.dart';

class WorkTextColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextColumn(
      title: 'Take Notes',
      text:
          'Post details about exact location and shot and see what subject interest you.',
    );
  }
}
