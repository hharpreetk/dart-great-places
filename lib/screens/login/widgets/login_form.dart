import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:great_places/constants.dart';
import 'package:great_places/screens/home/places_list_screen.dart';
import 'package:great_places/services/auth.dart';
import './custom_button.dart';
import './fade_slide_transition.dart';

class LoginForm extends StatefulWidget {
  final Animation<double> animation;

  LoginForm({
    @required this.animation,
  }) : assert(animation != null);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? kSpaceM : kSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            FadeSlideTransition(
              animation: widget.animation,
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
              animation: widget.animation,
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
              animation: widget.animation,
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
              animation: widget.animation,
              additionalOffset: 3 * space,
              child: CustomButton(
                color: kWhite,
                textColor: kBlack.withOpacity(0.5),
                text: 'Login Anonymously',
                outline: true,
                onPressed: () async {
                  dynamic result = await _auth.signInAnon();
                  if (result == null) {

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
              animation: widget.animation,
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
    );
  }
}
