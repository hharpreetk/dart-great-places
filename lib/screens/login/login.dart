import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:great_places/constants.dart';
import 'package:great_places/screens/home/places_list_screen.dart';
import 'package:great_places/screens/login/widgets/custom_button.dart';
import 'package:great_places/screens/login/widgets/fade_slide_transition.dart';
import 'package:great_places/services/auth.dart';
import 'package:great_places/widgets/loading.dart';
import './widgets/custom_clippers/index.dart';
import './widgets/header.dart';
import './widgets/login_form.dart';

class Login extends StatefulWidget {
  final double screenHeight;

  const Login({
    @required this.screenHeight,
  }) : assert(screenHeight != null);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {

  static const String routename = '/login';

  AnimationController _animationController;
  Animation<double> _headerTextAnimation;
  Animation<double> _formElementAnimation;
  Animation<double> _whiteTopClipperAnimation;
  Animation<double> _blueTopClipperAnimation;
  Animation<double> _greyTopClipperAnimation;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: kLoginAnimationDuration,
    );

    var fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    _headerTextAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.6,
        curve: Curves.easeInOut,
      ),
    ));
    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));

    var clipperOffsetTween = Tween<double>(
      begin: widget.screenHeight,
      end: 0.0,
    );
    _blueTopClipperAnimation = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.2,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _greyTopClipperAnimation = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.35,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _whiteTopClipperAnimation = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.5,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? kSpaceM : kSpaceS;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kWhite,
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: _whiteTopClipperAnimation,
            child: Container(
              color: kGrey,
            ),
            builder: (_, Widget child) {
              return ClipPath(
                clipper: WhiteTopClipper(
                  yOffset: _whiteTopClipperAnimation.value,
                ),
                child: child,
              );
            },
          ),
          AnimatedBuilder(
            animation: _greyTopClipperAnimation,
            child: Container(
              color: kBlue,
            ),
            builder: (_, Widget child) {
              return ClipPath(
                clipper: GreyTopClipper(
                  yOffset: _greyTopClipperAnimation.value,
                ),
                child: child,
              );
            },
          ),
          AnimatedBuilder(
            animation: _blueTopClipperAnimation,
            child: Container(
              color: kWhite,
            ),
            builder: (_, Widget child) {
              return ClipPath(
                clipper: BlueTopClipper(
                  yOffset: _blueTopClipperAnimation.value,
                ),
                child: child,
              );
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kPaddingL),
              child: Column(
                children: <Widget>[
                  Header(
                    animation: _headerTextAnimation,
                  ),
                  Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: 0.0,
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(kPaddingM),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.12),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.12),
                              ),
                            ),
                            hintText: 'Username or Email',
                            hintStyle: TextStyle(
                              color: kBlack.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: kBlack.withOpacity(0.5),
                            ),
                          ),
                          obscureText: false,
                          validator: (val) => val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: space),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(kPaddingM),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.12),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.12),
                              ),
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: kBlack.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: kBlack.withOpacity(0.5),
                            ),
                          ),
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ characters long'
                              : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: space),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: 2 * space,
                        child: CustomButton(
                          color: kBlue,
                          textColor: kWhite,
                          text: 'Login to continue',
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {

                              dynamic result =
                              await _auth.signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Could not sign in with those credentials.';
                                });
                              } else {
                                setState(() {
                                  error = '';
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlacesListScreen(),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      SizedBox(height: 2 * space),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: 3 * space,
                        child: CustomButton(
                          color: kWhite,
                          textColor: kBlack.withOpacity(0.5),
                          text: 'Login Anonymously',
                          outline: true,
                          onPressed: () async {
                            dynamic result = await _auth.signInAnon();
                            if (result == null) {
                              //print('error signing in');
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlacesListScreen(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: space),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: 4 * space,
                        child: CustomButton(
                          color: kBlack,
                          textColor: kWhite,
                          text: 'Create Great Places Account',
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
                  /*LoginForm(
                    animation: _formElementAnimation,
                  ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
