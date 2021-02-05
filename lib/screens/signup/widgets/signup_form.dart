import 'package:flutter/material.dart';
import 'package:great_places/constants.dart';
import 'package:great_places/screens/home/places_list_screen.dart';
import 'package:great_places/screens/home/widgets/fade_slide_transition.dart';
import 'package:great_places/screens/login/widgets/custom_button.dart';
import 'package:great_places/services/auth.dart';

class SignUpForm extends StatefulWidget {
  final Animation<double> animation;

  SignUpForm({
    @required this.animation,
  }) : assert(animation != null);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
                text: 'Sign Up For Great Places',
                onPressed: () async {
                  if (_formKey.currentState.validate()) {

                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password);
                    if(result == null){
                     setState(() {

                       error = 'Email is invalid or already exist.';
                     });
                    }
                    else{
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
            SizedBox(height: 11,),
            Text(error,style: TextStyle(color: Colors.red, fontSize: 14),)
          ],
        ),
      ),
    );
  }
}
