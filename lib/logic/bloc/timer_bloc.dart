import 'dart:async';

import 'package:aesthetic_timer/data/timer_ticker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final TimerTicker _timerTicker;
  static const int _duration = 60; // seconds

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required TimerTicker timerTicker})
      : _timerTicker = timerTicker,
        super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);

    on<TimerResumed>(_onResumed);
    on<TimerPaused>(_onPaused);
    on<TimerReset>(_onReset);
    on<_TimerTicked>(_onTicked);
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();

    _tickerSubscription =
        _timerTicker.ticks(ticks: event.duration).listen((duration) {
      return add(TimerStarted(duration: duration));
    });
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  void _onResumed(TimerResumed event, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();

    emit(const TimerInitial(_duration));
  }

  void _onTicked(_TimerTicked event, Emitter<TimerState> emit) {
    emit(
      event.duration > 0
          ? TimerRunInProgress(event.duration)
          : const TimerRunComplete(),
    );
  }
}
