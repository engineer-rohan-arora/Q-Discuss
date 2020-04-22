import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qdiscuss/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore= Firestore.instance;
final CollectionReference postsRef = Firestore.instance.collection('/posts');
var postID = 1;
FirebaseUser loggedInUser;
class ChatScreen extends StatefulWidget {
static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messagetextcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText;


  void getCurrentUser() async{
    try{
      final user= await _auth.currentUser();
      if(user != null){
        loggedInUser= user;
      }
    }catch(e){
      print(e);
    }
  }
//
//  void getMessages()async{
//   final messages = await _firestore.collection('messages').getDocuments();
//   for(var message in messages.documents){
//     print(message.data);
//   }
//  }


  void messagesStream() async {
    await for ( var snapshot in  _firestore.collection('messages').snapshots()){
      for(var message in snapshot.documents){
        print(message.data);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                messagesStream();
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Q Discuss'),
        backgroundColor: Color(0xFF812972),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration.copyWith(color: Color(0xFF812972)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messagetextcontroller ,
                      onChanged: (value) {
                        messageText=value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  FlatButton (
                    onPressed:
                        () async{
                      messagetextcontroller.clear();
                      final tstamp = (( DateTime.now().millisecondsSinceEpoch).toString()+loggedInUser.email);
                      _firestore.collection('messages')
                      .document('$tstamp')
                      .setData
                        ({
                        'text':messageText.toString(),
                        'sender':loggedInUser.email,
                        'time_stamp': tstamp,
                      });
                      setState(() {
                        messageText=null;
                      });
                    } ,
                    child: Text(
                      'Send / 👍',
                      style: kSendButtonTextStyle,
                    ),
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
class MessagesStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      // ignore: missing_return
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );

        }
        {
          final messages = snapshot.data.documents.reversed;
          List<MessageBubble> messageWidgets = [];
          // ignore: missing_return
          for (var message in messages){
            final messageText = message.data['text'];
            final messageData = message.data['sender'];
            final currentUser = loggedInUser.email;

            final messageWidget = MessageBubble(sender:messageData , text: messageText,isme: currentUser==messageData,);
            messageWidgets.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageWidgets,
            ),
          );
        }
      } ,
    );
  }
}


class MessageBubble extends StatelessWidget {

  MessageBubble({this.sender,this.text,this.isme});

  final String sender;
  final String text;
  final bool isme;

  @override
  Widget build(BuildContext context) {
    return (text =='null') ?  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isme? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: <Widget>[
          Text(sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),),
          Material(
            borderRadius: isme? BorderRadius.only(
              topLeft:Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ): BorderRadius.only(
              topRight:Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            elevation: 5.0,
            color: isme ?(Color(0xFF812972)) : Colors.white  ,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),

              child: Text("👍",
              ),
            ),
          ),
        ],
      ),
    ):Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isme? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: <Widget>[
          Text(sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),),
          Material(
            borderRadius: isme? BorderRadius.only(
              topLeft:Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ): BorderRadius.only(
              topRight:Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            elevation: 5.0,
            color: isme ?(Color(0xFF812972)) : Colors.white ,
            //Color(0xFF812972),
            //isme ? (Color(0xFF812972)) : (Color(0xAF812972)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),

              child: Text(text,
                style: TextStyle(
                  color: isme ?Colors.white : (Color(0xFF812972)) ,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
