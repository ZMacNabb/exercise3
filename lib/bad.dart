import 'package:flutter/material.dart';

class Bad extends StatelessWidget {
  final xdir;
  final ydir;
  Bad(this.xdir, this.ydir);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(xdir, ydir),

      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        width: 30,
        height: 30,
      ),
    );
  }
}
