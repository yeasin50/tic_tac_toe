import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/src/presentation/bloc/ai_player.dart';
import 'package:tic_tac_toe/src/presentation/bloc/game_state_mixin.dart';
import 'package:tic_tac_toe/src/presentation/bloc/tic_tac_toe_game_engine.dart';

void main() {
  group(
    "AIPlayer movement test ",
    () {
      //
      final aiPlayer = AIPlayer();
      test("should return index 4 to block the x", () {
        final engine = TicTacToeGameEngine();
        engine.init();
        engine.onXPressed(index: 1);
        engine.onXPressed(index: 7);
        expect(aiPlayer.findBestMove(engine.data), 4);
      });
    },
  );
}
