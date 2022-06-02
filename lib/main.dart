import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exercise3/bucket.dart';
import 'package:exercise3/ball.dart';
import 'package:exercise3/bad.dart';
import 'package:exercise3/home.dart';
import 'dart:math';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bucket Game',
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}
enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  double controlled =  0;
  double width = 0.4;
  int score = 0;

  double bx = (Random().nextDouble())*2-1;
  double bax = (Random().nextDouble())*2-1;
  double ba2x = (Random().nextDouble())*2-1;
  double b2x = (Random().nextDouble())*2-1;
  double b3x = (Random().nextDouble())*2-1;
  double by = -1;
  double b2y = -1.8;
  double b3y = -2.2;
  double bay = -1.5;
  double ba2y = -2.0;
  var byd = direction.DOWN;
  var b2yd = direction.DOWN;
  var b3yd = direction.DOWN;
  var bayd = direction.DOWN;
  var bay2d = direction.DOWN;
  bool st = false;


  void startGame() {
    st = true;
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      direc();
      balldirec();

      if (by >= 0.9 && by<0.95 && controlled + width>= bx && controlled <= bx) {
        score++;
        bx=(Random().nextDouble())*2-1;
        by=-1;
        by += (Random().nextInt(20))/1000;
      }
      if (b2y >= 0.9 && b2y<0.95 && controlled + width>= b2x && controlled <= b2x) {
        score++;
        b2x=(Random().nextDouble())*2-1;
        b2y=(Random().nextDouble())-2;
        b2y += (Random().nextInt(20))/1000;
      }
      if (b3y >= 0.9 && b3y<0.95 && controlled + width>= b3x && controlled <= b3x) {
        score++;
        b3x=(Random().nextDouble())*2-1;
        b3y=-1;
        b3y += (Random().nextInt(20))/1000;
      }
      if (by >= 1  ) {
        bx=(Random().nextDouble())*2-1;
        by=-1;
        by += (Random().nextInt(20))/1000;
      }
      if (b3y >= 1  ) {
        b3x=(Random().nextDouble())*2-1;
        b3y=-1;
        b3y += (Random().nextInt(20))/1000;
      }
      if (b2y >= 1  ) {
        b2x=(Random().nextDouble())*2-1;
        b2y=(Random().nextDouble())-2;
        b2y += (Random().nextInt(20))/1000;
      }

      if (bay >= 0.9 && bay<0.95 && controlled + width>= bax && controlled <= bax) {

        text(true);
      }

      if (bay >= 1  ) {
        bax=(Random().nextDouble())*2-1;
        bay=(Random().nextDouble())-2;
      }
      if (ba2y >= 0.9 && ba2y<0.95 && controlled + width>= ba2x && controlled <= ba2x) {

        text(true);
      }

      if (ba2y >= 1  ) {
        ba2x=(Random().nextDouble())*2-1;
        ba2y=(Random().nextDouble())-2;
      }
      if (score>=30) {
        text(true);
      }
    });
  }

  void text(bool Win) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(

            backgroundColor: Colors.black,
            title: Center(
                child:
                Text("Game Over",
                  style: TextStyle(color: Colors.white, fontSize:30),
                )
            ),
            actions: [
              GestureDetector(

                onTap: restart,
                child: ClipRRect(
                    child:  score >=30?
                    Text("You Win",
                      style: TextStyle(color: Colors.green, fontSize:50),
                      textAlign: TextAlign.center,
                    ):
                    Text("You lost",
                      style: TextStyle(color: Colors.red, fontSize: 50),
                      textAlign: TextAlign.center,
                    )),
              ),

            ],
          );
        });
  }



  void restart() {
    Navigator.pop(context);
    setState(() {
       st = false;
       controlled =  0;
       width = 0.4;
       score = 0;

       bx = (Random().nextDouble())*2-1;
       bax = (Random().nextDouble())*2-1;
       ba2x = (Random().nextDouble())*2-1;
       b2x = (Random().nextDouble())*2-1;
       b3x = (Random().nextDouble())*2-1;
       by = -1;
       b2y = -1.8;
       b3y = -2.2;
       bay = -1.5;
       ba2y = -1.5;
    });
  }




  void direc() {

    setState(() {
        byd = direction.DOWN;
        b2yd = direction.DOWN;
        b3yd = direction.DOWN;
        bayd = direction.DOWN;
        bay2d = direction.DOWN;
    });
  }

  void balldirec() {
    //vertical movement
    setState(() {
        by += 0.006;
        b2y += 0.008;
        b3y += 0.007;
        bay += 0.01;
        ba2y += 0.005;
    });
  }

  void left() {
    setState(() {
      if (!(controlled - 0.1 <= -1.3)) {
        controlled -= 0.30;
      }
    });
  }

  void right() {
    if (!(controlled + width >= 1)) {
      controlled += 0.30;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          left();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          right();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child:
        Scaffold(
            backgroundColor: Colors.blueGrey[900],
            body: Center(
                child:  Stack(
                  children: [
                    Welcome(st),
                    Score(st,score),
                    Ball(b2x, b2y),
                    Ball(bx, by),
                    Ball(b3x, b3y),
                    Bad(bax, bay),
                    Bad(ba2x, ba2y),
                    Brick(controlled, 1, width, false)
                  ],
                ))),
      ),
    );
  }
}

class Score extends StatelessWidget {
  final st;
  final score;
  Score(this.st,this.score, );

  @override
  Widget build(BuildContext context) {
    return st? Stack(children: [

      Container(
          alignment: Alignment(0.0, 0.0),
          child: Text(
            score.toString(),
            style: TextStyle(color: Colors.white, fontSize: 200),
          )),
    ]): Container();
  }
}