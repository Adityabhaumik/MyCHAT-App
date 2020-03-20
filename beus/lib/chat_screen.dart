import 'package:flutter/material.dart';
import 'package:beus/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatScreen extends StatefulWidget {
  FirebaseUser  loggedinUser;
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore=Firestore.instance;
  final _auth=FirebaseAuth.instance;
  FirebaseUser  loggedinUser;
  TextEditingController controller=TextEditingController();
  String message;
  @override
  void initState() {
    getCurrentuser();
   // messagesStream();
    super.initState();
  }


void messagesStream() async{

   await for( var snapshot in _firestore.collection('messages').snapshots()){
     for(var message in snapshot.documents){
       print(message.data);
     }
   }
}


  void getCurrentuser()async{
    final user =await _auth.currentUser();
    try{if(user!=null){
      loggedinUser=user;
      print(loggedinUser.email);
          }}catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(automaticallyImplyLeading: false,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.power_settings_new),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('beUs'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots() ,
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Container(child: CircularProgressIndicator(backgroundColor: Colors.deepPurple,));
                }
                  // ignore: missing_return
                  final messages=snapshot.data.documents.reversed;
                  List<messagebuble> messageWidgets=[];
                  for(var message in messages){
                    final messageText = message.data['text'];
                    final messageSender=message.data['sender'];

                    final currentUser = loggedinUser.email;



                    final messageWidget =messagebuble(text: messageText,sender: messageSender, Isme: currentUser==messageSender,);
                    messageWidgets.add(messageWidget);
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                      children: messageWidgets,
                    ),
                  );

              } ,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,

                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        message=value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration.copyWith(filled: true,fillColor: Colors.white,focusColor: Colors.white,border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0),),
                      ),),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.clear();
                      _firestore.collection('messages').add({'text':message,'sender':loggedinUser.email});
                      //Implement send functionality.
                    },
                    icon: Icon(Icons.send,color: Colors.deepPurpleAccent,)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class messagebuble extends StatelessWidget {
   final String sender;
   bool Isme;
   final String text;
   BorderRadius forme;
   Color Forme;
   messagebuble({this.sender,this.text,this.Isme});



   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: Isme?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: <Widget>[

          Text('$sender',style: TextStyle(color: Colors.white70,fontSize: 10),),
          Material(borderRadius: Isme?BorderRadius.only(
   topLeft: Radius.circular(30), bottomLeft: Radius.circular(30),
   bottomRight: Radius.circular(30), topRight: Radius.circular(0)):BorderRadius.only(
   topLeft: Radius.circular(0), bottomLeft: Radius.circular(30),
   bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
            child: Padding(
            padding:  EdgeInsets.symmetric(horizontal:8.0,vertical: 20),
            child: Text('$text',style: TextStyle(color: Colors.white),),
          ),color: Isme?Colors.blueAccent:Colors.indigo,elevation: 5.0,),
        ],
      ),
    );
  }
}
