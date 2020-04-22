import 'package:flutter/material.dart';
import 'package:qdiscuss/screens/welcome_screen.dart';
import 'package:qdiscuss/screens/login_screen.dart';
import 'package:qdiscuss/screens/registration_screen.dart';
import 'package:qdiscuss/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        hintColor: Colors.white,
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black),
        ),
      ),
      initialRoute: 'welcome_screen' ,
      routes: {
        'welcome_screen': (context)=> WelcomeScreen(),
        'login_screen': (context) => LoginScreen(),
        'registration_screen' : (context) =>  RegistrationScreen(),
        'chat_screen' : (context) => ChatScreen(),
      },
    );
  }
}