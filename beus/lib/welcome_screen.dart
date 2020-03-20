import 'package:beus/login_screen.dart';
import 'package:beus/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:beus/RoundedButton.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    controller.forward();
    //print(controller.value);
    //controller.addListener(() {
    //print(controller.value);
    // }); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    child: Image.asset('images/2.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 1000),
                  totalRepeatCount: null,
                  text: ['beUs'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                onpressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                colour: Colors.lightBlueAccent,
                title: 'LOGIN'),
            RoundedButton(
              onpressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
                //Go to login screen.
              },
              colour: Colors.lightBlueAccent,
              title: 'RIGESTER',
            ),
//            Padding(
//              padding: EdgeInsets.symmetric(vertical: 16.0),
//              child: Material(
//                elevation: 5.0,
//                color: Colors.lightBlueAccent,
//                borderRadius: BorderRadius.circular(30.0),
//                child: MaterialButton(
//                  onPressed: () {
//                    Navigator.pushNamed(context, LoginScreen.id);
//                    //Go to login screen.
//                  },
//                  minWidth: 200.0,
//                  height: 42.0,
//                  child: Text(
//                    'Log In',
//                  ),
//                ),
//              ),
//            ),
//            Padding(
//              padding: EdgeInsets.symmetric(vertical: 16.0),
//              child: Material(
//                color: Colors.blueAccent,
//                borderRadius: BorderRadius.circular(30.0),
//                elevation: 5.0,
//                child: MaterialButton(
//                  onPressed: () {
//                    Navigator.pushNamed(context, RegistrationScreen.id);
//                    //Go to registration screen.
//                  },
//                  minWidth: 200.0,
//                  height: 42.0,
//                  child: Text(
//                    'Register',
//                  ),
//                ),
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}
