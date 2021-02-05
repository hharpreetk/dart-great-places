import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:great_places/constants.dart';
import './fade_slide_transition.dart';
import 'package:great_places/widgets/logo.dart';

class Header extends StatelessWidget {
  final Animation<double> animation;

  const Header({
    @required this.animation,
  }) : assert(animation != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: kSpaceM),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 0.0,
            child: Text(
              'Welcome to Great Places',
              style: TextStyle(color: kBlack, fontWeight: FontWeight.bold, fontSize: 27)
            ),
          ),
          const SizedBox(height: kSpaceS),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 13.0,
            child: Text(
              'An easy solution to remembering your favorite locations.',
              style: TextStyle(color: kBlack.withOpacity(0.5), fontSize: 17.5,height: 1.3)
            ),
          ),
        ],
      ),
    );
  }
}
