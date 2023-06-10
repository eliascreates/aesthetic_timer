import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TimerBackground extends StatefulWidget {
  const TimerBackground({super.key});

  @override
  State<TimerBackground> createState() => _TimerBackgroundState();
}

class _TimerBackgroundState extends State<TimerBackground> {
  // late RiveAnimationController _controller;


  @override
  void initState() {
    // _controller = StateMachine.fro();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const RiveAnimation.asset(
      'assets/animations/pomobackground.riv',
      fit: BoxFit.fitHeight,
      // controllers: [
      //   _controller,
      // ],
    );
  }
}
