
class TimerTicker {
  Stream<int> ticks({required int ticks}) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (tick) => ticks - (tick + 1),
    ).take(ticks);
  }
}
