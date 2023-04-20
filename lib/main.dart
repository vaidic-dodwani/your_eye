import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:volume_controller/volume_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});
  String temp = "";
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    VolumeController().showSystemUI = false;
    VolumeController().listener((volume) {
      List<String> chars = widget.temp.split('');
      chars.sort();
      String sortedWord = chars.join();
      log(braileToText(sortedWord).toString());
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
              child: InkWell(onTap: () {
                widget.temp = widget.temp + "1";
              }),
            ),
            SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.5,
              child: InkWell(onTap: () {
                widget.temp = widget.temp + "2";
              }),
            )
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.5,
              child: InkWell(onTap: () {
                widget.temp = widget.temp + "3";
              }),
            ),
            SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.5,
              child: InkWell(onTap: () {
                widget.temp = widget.temp + "4";
              }),
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
