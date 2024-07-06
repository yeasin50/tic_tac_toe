import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/src/presentation/bloc/tic_tac_toe_game_engine.dart';

void main() {
  group("TicTacToeGameEngine", () {
    group("diagonal", () {
      test(
        "X should win from TopLeft to BottomRight when it takes",
        () {
          final engine = TicTacToeGameEngine();
          engine.init();
          engine.onXPressed(index: 0);
          engine.onXPressed(index: 4);
          engine.onXPressed(index: 8);
          expect(engine.gameState, GameState.winX);
        },
      );
      test(
        "Y should win from TopLeft to BottomRight when it takes",
        () {
          final engine = TicTacToeGameEngine();
          engine.init();
          engine.onOPressed(index: 0);
          engine.onOPressed(index: 4);
          engine.onOPressed(index: 8);
          expect(engine.gameState, GameState.winO);
        },
      );
      test(
        "X should win from BottomRight to TopLeft when it takes",
        () {
          final engine = TicTacToeGameEngine();
          engine.init();
          engine.onXPressed(index: 2);
          engine.onXPressed(index: 4);
          engine.onXPressed(index: 6);
          expect(engine.gameState, GameState.winX);
        },
      );
      test(
        "Y should win fromBottomRight to TopLeft when it takes",
        () {
          final engine = TicTacToeGameEngine();
          engine.init();
          engine.onOPressed(index: 2);
          engine.onOPressed(index: 4);
          engine.onOPressed(index: 6);
          expect(engine.gameState, GameState.winO);
        },
      );
    });

    ///

    group("X win on Column", () {
      test(
        "1st column should win when it takes",
        () {
          final engine = TicTacToeGameEngine();
          engine.init();
          engine.onXPressed(index: 0);
          engine.onXPressed(index: 3);
          engine.onXPressed(index: 6);
          expect(engine.gameState, GameState.winX);
        },
      );
    });

    test("O win Column", () {
      final engine = TicTacToeGameEngine();
      engine.init();
      engine.onOPressed(index: 0);
      engine.onOPressed(index: 3);
      engine.onOPressed(index: 6);
      expect(engine.gameState, GameState.winO);
    });

    ///todo: add false-positive || exceptions tests
  });
}
