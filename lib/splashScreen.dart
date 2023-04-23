import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:your_eye/main.dart';
import 'package:your_eye/tripleFinger.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThreeFingerGestureDetector(
      onThreeFingerTouch: () {
        log("adsads");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Payment App"),
        ),
        body: Column(children: [
          Center(
            child: Image.asset(
              "assets/paytm.png",
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(child: Text("Enter Upi Pin")),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextFormField(
              keyboardType: TextInputType.number,
            ),
          )
        ]),
      ),
    );
  }
}
