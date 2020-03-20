import 'package:beus/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:beus/RoundedButton.dart';
import 'package:beus/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth =FirebaseAuth.instance;
  String email;
  String password;
  Color eye=Colors.black12;
  bool coverText=true;
  SnackBar one=SnackBar(content: Text('Something Went Wrong :('));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(builder: (context)=> Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[ SizedBox(
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
                  height: 48.0,
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    email = value;
                    //Do something with the user input.
                  },
                  decoration:
                      kInputDecoration.copyWith(
                          hintText: 'Enter your Email',
                       ),
//
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  obscureText: coverText,
                  onChanged: (value) {
                    password = value;
                    //Do something with the user input.
                  },
                  decoration:
                      kInputDecoration.copyWith(hintText: 'Enter Passsword',suffixIcon: GestureDetector(child: Icon(Icons.remove_red_eye,color: eye,),
                        onTap: (){setState(() {if(coverText==true){ coverText=false;eye=Colors.blueAccent;}
                        else{
                          eye=Colors.black12;
                          coverText=true;
                        }

                      });},)),),
                RoundedButton(
                  onpressed: () async{
                   final newuser= await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    //Go to registration screen.
                    try{if(newuser!=null){
                      Navigator.pushNamed(context, ChatScreen.id);
                    }else{
                      print('nouser');//Scaffold.of(context).showSnackBar(one);
                      ///make snakbar
                    }}
                    catch(e)
                    {
                      Scaffold.of(context).showSnackBar(one);
                    }
                  },
                  colour: Colors.lightBlueAccent,
                  title: 'REGISTER',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//
//class RoundedButton extends StatelessWidget {
//  RoundedButton({this.colour, this.title, @required this.onpressed});
//  final Color colour;
//  final String title;
//  final Function onpressed;
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: EdgeInsets.symmetric(vertical: 16.0),
//      child: Material(
//        color: colour,
//        borderRadius: BorderRadius.all(Radius.circular(30.0)),
//        elevation: 5.0,
//        child: MaterialButton(
//          onPressed: onpressed()
//          //Implement registration functionality.
//          ,
//          minWidth: 200.0,
//          height: 42.0,
//          child: Text(
//            title,
//            style: TextStyle(color: Colors.white),
//          ),
//        ),
//      ),
//    );
//  }
//}
