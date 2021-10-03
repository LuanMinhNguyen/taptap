import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String startButton = 'Bắt đầu';
  String buttonStatus = 'Bắt đầu';
  int counter = 10;
  Timer? timer;
  List<bool> listIcon = [];
  int taps = 0;
  int scores = 0;
  int i = 4;

  @override
  void initState() {
    // ignore: unused_local_variable
    listIcon = [true, true, true, true, true];
    super.initState();
  }

  void startGame() {
    setState(() {
      if (buttonStatus == 'Bắt đầu') {
        timer?.isActive;
        buttonStatus = 'Tap Me';
        timer = Timer.periodic(Duration(seconds: 1), (timer) {
          setState(() {
            if (counter > 0) {
              counter--;
            } else {
              listIcon[i] = false;
              i--;
              counter = 10;
              if (i == -1) {
                timer.cancel();
                buttonStatus = 'Chơi lại';
              }
            }
          });
        });
      } else if (buttonStatus == 'Tap Me') {
        setState(() {
          if (taps == 10 && scores <= 5) {
            taps = 0;
            counter = 10;
            scores++;
          } else if (taps == 10 && (scores > 5 && scores <= 10)) {
            taps = 0;
            counter = 8;
            scores++;
          } else if (taps == 10 && (scores > 10 && scores <= 15)) {
            taps = 0;
            counter = 6;
            scores++;
          } else if (taps == 10 && (scores > 15 && scores <= 20)) {
            taps = 0;
            counter = 4;
            scores++;
          } else if (taps == 10 && (scores > 20 && scores <= 25)) {
            taps = 0;
            counter = 3;
            scores++;
          }
          taps++;
        });
      } else if (buttonStatus == 'Chơi lại') {
        buttonStatus = 'Bắt đầu';
        setState(() {
          scores = 0;
          taps = 0;
          counter = 10;
          i = 4;
          listIcon = [true, true, true, true, true];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'TapTap',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
          ),
          backgroundColor: Colors.orange[400],
        ),
        backgroundColor: Colors.red[50],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Tap Challenge !',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ]),
              SizedBox(
                height: 80,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Score: ' + scores.toString(),
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                ),
              ]),
              SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (int i = 0; i < 5; i++)
                  Icon(
                    listIcon[i] ? Icons.favorite : Icons.favorite_border,
                    color: listIcon[i] ? Colors.red : Colors.black,
                    size: 36,
                  ),
              ]),
              SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Time: ' + counter.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Tap: ' + taps.toString(),
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ]),
              SizedBox(
                height: 40,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: startGame,
                  child: Text(
                    buttonStatus,
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                    fixedSize: MaterialStateProperty.all(Size(90, 40)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.orange),
                    )),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
