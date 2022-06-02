import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {

  final bool st;
  Welcome(this.st);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(0, 0),
        child: Text(
            st ? "": "Instructions: use Left and Right Arrow Key to move\n"
                "Game Ends in a lost if a red ball is touched\n"
                "Game Ends in a win if 30 green balls is touched\n"
                "Click to Begin",
            style: TextStyle(color: Colors.white, fontSize: 50),
            textAlign: TextAlign.center
        ));
  }
}