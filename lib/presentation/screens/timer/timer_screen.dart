import 'package:aesthetic_timer/data/timer_ticker.dart';
import 'package:aesthetic_timer/logic/bloc/timer_bloc.dart';
import 'package:aesthetic_timer/presentation/screens/timer/components/timer_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/timer_text.dart';
// import 'package:rive/rive.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimerBloc>(
      create: (context) => TimerBloc(timerTicker: TimerTicker()),
      child: const Scaffold(
        body: TimerView(),
      ),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const TimerBackground(),
        const Positioned(
          top: 100,
          child: TimerText(),
        ),
        Positioned(
          bottom: 50,
          child: Row(
            children: [
              Builder(
                builder: (context) {
                  final state = context
                      .select<TimerBloc, TimerState>((bloc) => bloc.state);

                  if (state is TimerRunInProgress) {
                    return FloatingActionButton(
                      onPressed: () =>
                          context.read<TimerBloc>().add(const TimerPaused()),
                      backgroundColor: const Color(0xff6a161e),
                      child: const Icon(
                        Icons.pause_rounded,
                        size: 40,
                      ),
                    );
                  } else {
                    return FloatingActionButton(
                      onPressed: state is TimerRunComplete
                          ? null
                          : () => context.read<TimerBloc>().add(
                                state is TimerInitial
                                    ? TimerStarted(duration: state.duration)
                                    : const TimerResumed(),
                              ),
                      backgroundColor: const Color(0xff6a161e),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        size: 40,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(width: 50),
              FloatingActionButton(
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerReset()),
                backgroundColor: const Color(0xff6a161e),
                child: const Icon(
                  Icons.replay_rounded,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
