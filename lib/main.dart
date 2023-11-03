// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StopWatchHMS(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StopWatchHMS extends StatefulWidget {
  const StopWatchHMS({super.key});

  @override
  State<StopWatchHMS> createState() => _StopWatchHMSState();
}

class _StopWatchHMSState extends State<StopWatchHMS> {
  // Time duration to Start counter from here
  Duration duration = Duration(seconds: 0);
  bool isRuning = false;
  Timer? repFun;

  // function to calculate the time  periodic
  startTimer() {
    //   seconds
    repFun = Timer.periodic(
        Duration(
          seconds: 1,
        ), (timer) {
      setState(() {
        int newSecond = duration.inSeconds;
        duration = Duration(seconds: newSecond + 1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 40, 43),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    // color: Colors.white,
                    margin: EdgeInsets.only(bottom: 22),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Colors.white),
                    child: Text(
                      duration.inHours.toString().padLeft(2, "0"),
                      style: TextStyle(
                        fontSize: 70,
                      ),
                    ),
                  ),
                  Text(
                    "Hour",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              SizedBox(width: 22),
              Column(
                children: [
                  Container(
                    // color: Colors.white,
                    margin: EdgeInsets.only(bottom: 22),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Colors.white),
                    child: Text(
                      duration.inMinutes
                          .remainder(60)
                          .toString()
                          .padLeft(2, "0"),
                      style: TextStyle(
                        fontSize: 70,
                      ),
                    ),
                  ),
                  Text(
                    "Minute",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              SizedBox(width: 22),
              Column(
                children: [
                  Container(
                    // color: Colors.white,
                    margin: EdgeInsets.only(bottom: 22),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Colors.white),
                    child: Text(
                      duration.inSeconds
                          .remainder(60)
                          .toString()
                          .padLeft(2, "0"),
                      style: TextStyle(
                        fontSize: 70,
                      ),
                    ),
                  ),
                  Text(
                    "Second",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 55,
          ),
          isRuning
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (repFun!.isActive) {
                          setState(() {
                            repFun!.cancel();
                          });
                        } else {
                          startTimer();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                      child: Text(
                        (repFun!.isActive) ? "STOP" : "RESUME",
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        repFun!.cancel();
                        setState(() {
                          duration = Duration(seconds: 0);
                          isRuning = false;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                      child: Text(
                        "CANCEL",
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ],
                )
              : ElevatedButton(
                  onPressed: () {
                    startTimer();
                    setState(() {
                      isRuning = true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9))),
                  ),
                  child: Text(
                    "START TIMER",
                    style: TextStyle(fontSize: 23),
                  ),
                )
        ],
      ),
    );
  }
}
