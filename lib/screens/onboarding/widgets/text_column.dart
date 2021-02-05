import 'package:flutter/material.dart';

import 'package:great_places/constants.dart';

class TextColumn extends StatelessWidget {
  final String title;
  final String text;

  const TextColumn({
    @required this.title,
    @required this.text,
  })  : assert(title != null),
        assert(text != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: kWhite, fontWeight: FontWeight.w500, fontSize: 23),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(fontSize: 19, color: kWhite, height: 1.4, ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
