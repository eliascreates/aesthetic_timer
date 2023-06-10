import 'package:aesthetic_timer/core/themes/timer_theme.dart';
import 'package:aesthetic_timer/presentation/screens/timer/timer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/utils/timer_observer.dart';

void main() {
  Bloc.observer = TimerObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aesthetic Timer',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const TimerScreen(),
    );
  }
}
