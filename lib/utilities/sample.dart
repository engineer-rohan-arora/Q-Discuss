import 'package:flutter/material.dart';

// ignore: camel_case_types
class sample extends StatelessWidget {

  sample({this.txt,@required this.onpresses});

  final String txt;
  final Function onpresses;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        child: MaterialButton(
          onPressed: onpresses,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            txt,
            style: TextStyle(
              color: Color(0xFF812972),
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),

          ),
        ),
      ),
    );
  }
}


// ignore: camel_case_types
class sample2 extends StatelessWidget {
  sample2({this.txt,@required this.onpresses});

  final String txt;
  final Function onpresses;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        //Do something with the user input.
      },
      decoration: InputDecoration(
        hintText: txt,
        contentPadding:
        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 4.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}