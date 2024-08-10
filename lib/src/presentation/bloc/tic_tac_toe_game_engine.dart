import '../models/toe_data.dart';
import 'game_state_mixin.dart';

enum GameState {
  playing,
  winX,
  winO,
  tie;

  bool get isGameOver => this != GameState.playing;
}

class CurrentGameState {
  final GameState gameState;

  final (int x1, int y1, int x2, int y2)? winnerLine;

  const CurrentGameState({this.gameState = GameState.playing, this.winnerLine});
}

abstract class ITicTacToeGameEngine {
  void init();

  void dispose();

  void onXPressed({required int index});

  void onOPressed({required int index});

  CurrentGameState get currentGameState;

  List<ToeData> get data;
}

class TicTacToeGameEngine extends ITicTacToeGameEngine with GameStateMixin {
  List<ToeData> _data = [];

  @override
  List<ToeData> get data => [..._data];

  @override
  void dispose() => _data.clear();

  @override
  void init() {
    _data = List.generate(
      boardSize * boardSize,
      (index) => ToeData(
        state: ToeState.empty,
        index: index,
      ),
    );
  }

  @override
  CurrentGameState get currentGameState => getCurrentGameState(_data);

  @override
  void onOPressed({required int index}) {
    _data[index] = ToeData(
      state: ToeState.o,
      index: index,
    );
  }

  @override
  void onXPressed({required int index}) {
    _data[index] = ToeData(
      state: ToeState.x,
      index: index,
    );
  }
}
