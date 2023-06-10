import 'package:aesthetic_timer/logic/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerText extends StatelessWidget {
  const TimerText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int duration =
        context.select<TimerBloc, int>((bloc) => bloc.state.duration);

    final String minutes =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final String seconds = (duration % 60).floor().toString().padLeft(2, '0');

    return Text(
      '$minutes:$seconds',
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}
