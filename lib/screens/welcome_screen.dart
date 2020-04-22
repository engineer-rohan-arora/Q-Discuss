import 'package:flutter/material.dart';
import 'package:qdiscuss/screens/login_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:qdiscuss/utilities/sample.dart';
class WelcomeScreen extends StatefulWidget {

static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds:1),
      vsync: this,
    );
    animation = ColorTween(begin:Colors.black, end: Color(0xFF812972)).animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {
      });
      //print(controller.value);
    } );

    //animation= CurvedAnimation(parent: null, curve: null);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                TyperAnimatedTextKit(
                  text : ['Q Discuss'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            sample(txt: 'Log In',onpresses: () {Navigator.pushNamed(context, LoginScreen.id);},),
            sample(txt: 'Register',onpresses: () {Navigator.pushNamed(context, RegistrationScreen.id);},),
          ],
        ),
      ),
    );
  }
}


