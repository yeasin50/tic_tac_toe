enum ToeState {
  empty,
  x,
  o,
  win;

  bool get isTaken => this == x || this == o;
}

class ToeData {
  const ToeData({
    required this.state,
    required this.index,
  });

  final ToeState state;
  final int index;
}
