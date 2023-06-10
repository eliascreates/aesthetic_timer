import 'package:aesthetic_timer/core/constants/strings.dart';
import 'package:aesthetic_timer/logic/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

class TimerBackground extends StatefulWidget {
  const TimerBackground({super.key});

  @override
  State<TimerBackground> createState() => _TimerBackgroundState();
}

class _TimerBackgroundState extends State<TimerBackground> {
  SMIInput<bool>? _isWorkingInput;
  SMIInput<bool>? _isIdleInput;
  Artboard? _timerAnimationArtboard;
  late bool themeIsChanged;
  @override
  void initState() {
    super.initState();

    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    themeIsChanged = isLightMode;
    setBackground(isLightMode
        ? Strings.lightAnimatedBackground
        : Strings.darkAnimatedBackground);
  }

  @override
  void didChangeDependencies() {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    if (isLightMode != themeIsChanged) {
      setBackground(isLightMode
          ? Strings.lightAnimatedBackground
          : Strings.darkAnimatedBackground);
    }

    super.didChangeDependencies();
  }

  void setBackground(String asset) {
    rootBundle.load(asset).then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller = StateMachineController.fromArtboard(
        artboard,
        'TimerAnimation',
      );

      if (controller != null) {
        artboard.addController(controller);
        _isWorkingInput = controller.findInput('isWorking');
        _isIdleInput = controller.findInput('idle');
      }
      setState(() => _timerAnimationArtboard = artboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<TimerBloc>();

    switch (bloc.state) {
      case TimerInitial() || TimerRunComplete():
        {
          _isWorkingInput?.value = true;
          _isIdleInput?.value = true;
        }
        break;
      case TimerRunInProgress():
        {
          _isWorkingInput?.value = true;
          _isIdleInput?.value = false;
        }
        break;
      case TimerRunPause():
        {
          _isWorkingInput?.value = false;
          _isIdleInput?.value = false;
        }
        break;
    }
    final Size size = MediaQuery.of(context).size;
    return _timerAnimationArtboard == null
        ? const SizedBox()
        : SizedBox(
            height: size.height - 140,
            child: Rive(
              artboard: _timerAnimationArtboard!,
              fit: BoxFit.cover,
              alignment: const Alignment(0.15, 0),
            ),
          );
  }
}
