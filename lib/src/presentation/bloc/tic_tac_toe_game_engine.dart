import '../models/toe_data.dart';
import 'game_state_mixin.dart';

enum GameState {
  // idle,
  playing,
  winX,
  winO,
  tie;

  bool get isGameOver => this != GameState.playing;
}

abstract class ITicTacToeGameEngine {
  void init();

  void dispose();

  void onXPressed({required int index});

  void onOPressed({required int index});

  GameState get gameState;

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
  GameState get gameState => getCurrentGameState(_data);

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
