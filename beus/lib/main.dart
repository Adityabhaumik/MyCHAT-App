import 'package:flutter/material.dart';
import 'package:beus/welcome_screen.dart';
import 'package:beus/login_screen.dart';
import 'package:beus/registration_screen.dart';
import 'package:beus/chat_screen.dart';
void main() => runApp(beus());

class beus extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute:ChatScreen.id,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget
        // When navigating to the "/second" route, build the SecondScreen widget.
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}


