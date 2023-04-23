import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ThreeFingerGestureDetector extends StatefulWidget {
  final Widget child;
  final Function onThreeFingerTouch;

  const ThreeFingerGestureDetector({
    Key? key,
    required this.child,
    required this.onThreeFingerTouch,
  }) : super(key: key);

  @override
  _ThreeFingerGestureDetectorState createState() =>
      _ThreeFingerGestureDetectorState();
}

class _ThreeFingerGestureDetectorState
    extends State<ThreeFingerGestureDetector> {
  bool _isThreeFingerTouching = false;

  void _handleScaleStart(ScaleStartDetails details) {
    if (details.pointerCount == 3) {
      setState(() {
        _isThreeFingerTouching = true;
      });
      widget.onThreeFingerTouch();
    }
  }

  void _handleScaleEnd(ScaleEndDetails details) {
    setState(() {
      _isThreeFingerTouching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onScaleStart: _handleScaleStart,
      onScaleEnd: _handleScaleEnd,
      child: widget.child,
    );
  }
}
