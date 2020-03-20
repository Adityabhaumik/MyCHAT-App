import 'package:flutter/material.dart';
import 'package:beus/RoundedButton.dart';
import 'package:beus/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';


class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth=FirebaseAuth.instance;
  String email;
  String password;
  Color eye=Colors.black12;
  bool coverText=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 48.0,
              ),
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/2.png'),
                ),
              ),
              SizedBox(
                height: 68.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  email=value;
                  //Do something with the user input.
                },
                decoration:
                    kInputDecoration.copyWith(hintText: 'Enter Your Email'),

              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: coverText,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  password=value;
                  //Do something with the user input.
                },
                decoration: kInputDecoration.copyWith(hintText: 'Password',suffixIcon: GestureDetector(child: Icon(Icons.remove_red_eye,color: eye,),
                  onTap: (){setState(() {if(coverText==true){ coverText=false;eye=Colors.blueAccent;}
                  else{
                    eye=Colors.black12;
                    coverText=true;
                  }

                  });},)),
//
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                onpressed: ()  async{
                  final newuser= await _auth.signInWithEmailAndPassword(email: email, password: password);
                  //Go to registration screen.
                  try{if(newuser!=null){
                    Navigator.pushNamed(context, ChatScreen.id);
                  }else{// Scaffold.of(context).showSnackBar(one);
                    ///make snakbar
                  }}
                  catch(e)
                  {
                    //Scaffold.of(context).showSnackBar(one);
                  }
                },
                title: 'LOGIN',
                colour: Colors.blueAccent,
              )

            ],
          ),
        ),
      ),
    );
  }
}
