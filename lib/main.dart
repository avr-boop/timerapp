import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Timers(),
    debugShowCheckedModeBanner: false,
  ));
}

class Timers extends StatefulWidget {
  const Timers({Key? key}) : super(key: key);

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timers> {
  bool isVisible = true;
  bool isVisible1 = false;
  int secDuration = 0;
  final myController = TextEditingController();
  late Timer timerObject;
  String pauseStop = "Stop Timer";
  void startTimer(int duration) {
    secDuration = duration;
    timerObject = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (secDuration > 0) {
          secDuration--;
        } else {
          timerObject.cancel();
          SystemSound.play(SystemSoundType.alert);
        }
      });
    });
  }

  void pauseTimer() {
    timerObject.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [Colors.pink.shade300, Colors.orange])),
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 350, 0, 0),
                      child: Text(
                        "$secDuration seconds",
                        style: TextStyle(
                            fontSize: 28.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 250,
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: Column(
                      children: [
                        TextField(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            obscureText: false,
                            controller: myController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.white60, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              labelText: "Enter the duration",
                              labelStyle: TextStyle(color: Colors.black87),
                              hintText: 'Please enter in minutes.',
                            )),
                        SizedBox(
                          height: 34.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Visibility(
                              visible: isVisible,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible1 = true;
                                    isVisible = false;
                                    secDuration =
                                        int.parse(myController.text) * 60;
                                    startTimer(secDuration);
                                  });
                                },
                                child: Text("Start Timer"),
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Colors.white,
                                  elevation: 20.0,
                                  shadowColor: Colors.blueAccent,
                                  onSurface: Colors.red.shade400,
                                  primary: Colors.red.shade400,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: isVisible1,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (pauseStop == "Stop Timer") {
                                      pauseStop = "Resume";
                                      pauseTimer();
                                    } else {
                                      pauseStop = "Stop Timer";
                                      startTimer(secDuration);
                                    }
                                  });
                                },
                                child: Text("$pauseStop"),
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Colors.white,
                                  elevation: 20.0,
                                  shadowColor: Colors.blueAccent,
                                  onSurface: Colors.red.shade400,
                                  primary: Colors.red.shade400,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  secDuration = 0;
                                  pauseStop = "Stop Timer";
                                  isVisible = true;
                                  isVisible1 = false;
                                  pauseTimer();
                                });
                              },
                              child: Text("Reset Timer"),
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                elevation: 20.0,
                                shadowColor: Colors.blueAccent,
                                onSurface: Colors.red.shade400,
                                primary: Colors.red.shade400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
