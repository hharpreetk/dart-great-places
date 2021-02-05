import 'package:flutter/material.dart';

import 'package:great_places/screens/onboarding/widgets/text_column.dart';
import 'package:path/path.dart';

class CommunityTextColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextColumn(

      title: 'Great Places',
      text:
          'Want to find a way back to your favorite place. Great Places is just for you. ',
    );
  }
}
