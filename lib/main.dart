import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:toast/toast.dart';
import 'package:vibration/vibration.dart';
import 'package:your_eye/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  double currentvol = 0.5;
  String temp = "";
  String ans = "";
  int currentLength = 0;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      widget.currentvol = await PerfectVolumeControl.getVolume();
    });

    PerfectVolumeControl.stream.listen((volume) async {
      if (volume != widget.currentvol) {
        //only execute button type check once time

        if (volume > widget.currentvol) {
          List<String> chars = widget.temp.split('');
          chars.sort();
          String sortedWord = chars.join();
          if (braileToText(sortedWord) != -1) {
            widget.ans += braileToText(sortedWord).toString();

            widget.temp = "";

            if (widget.currentLength == 3 && widget.ans.length == 4) {
              AssetsAudioPlayer.newPlayer().open(
                Audio("assets/whole pin accept.wav"),
                showNotification: false,
              );
            } else {
              AssetsAudioPlayer.newPlayer().open(
                Audio("assets/single number accept.wav"),
                showNotification: false,
              );
              //play single correct
            }
          } else {
            Vibration.vibrate(duration: 1000);
            widget.temp = "";

//play wrong sound
          }
          log(widget.ans);
        } else {
          if (widget.ans.isNotEmpty) {
            widget.ans = widget.ans.substring(0, widget.ans.length - 1);
          }
        }

        if (widget.ans.isNotEmpty) {
          ToastContext().init(context);
          Toast.show(widget.ans,
              duration: Toast.lengthShort, gravity: Toast.bottom);
        } else {
          ToastContext().init(context);
          Toast.show("empty",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
      }
      widget.currentvol = volume;
      widget.currentLength = widget.ans.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(children: [
        Row(
          children: [
            SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.5,
              child: InkWell(
                onTap: () {
                  widget.temp = widget.temp + "1";
                },
                highlightColor: Colors.black,
              ),
            ),
            SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.5,
              child: InkWell(
                onTap: () {
                  widget.temp = widget.temp + "2";
                },
                highlightColor: Colors.black,
              ),
            )
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.5,
              child: InkWell(
                onTap: () {
                  widget.temp = widget.temp + "3";
                },
                highlightColor: Colors.black,
              ),
            ),
            SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.5,
              child: InkWell(
                onTap: () {
                  widget.temp = widget.temp + "4";
                },
                highlightColor: Colors.black,
              ),
            )
          ],
        )
      ]),
    );
  }
}

int braileToText(String text) {
  if (text == "1") {
    return 1;
  } else if (text == "13") {
    return 2;
  } else if (text == "12") {
    return 3;
  } else if (text == "124") {
    return 4;
  } else if (text == "14") {
    return 5;
  } else if (text == "123") {
    return 6;
  } else if (text == "1234") {
    return 7;
  } else if (text == "134") {
    return 8;
  } else if (text == "23") {
    return 9;
  } else if (text == "234") {
    return 0;
  } else {
    return -1;
  }
}
