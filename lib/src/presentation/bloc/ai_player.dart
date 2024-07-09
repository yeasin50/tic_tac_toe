import '../models/toe_data.dart';
import 'game_state_mixin.dart';
import 'dart:math' as math;

import 'tic_tac_toe_game_engine.dart';

/// decide the best possible move for the player.
///  [List<ToeData>] is the current board state which will length of 9
///   X - is the maximizing player, score will be positive
///   O - is the minimizing player, score will be negative
class AIPlayer with GameStateMixin {
  int? findBestMove(List<ToeData> board, {bool isMaximizingPlayer = false}) {
    assert(board.length == 9, "boardState length should be 9");

    int? bestMoveIndex;
    int bestScore = isMaximizingPlayer ? -1000 : 1000;

    //
    for (int i = 0; i < board.length; i++) {
      if (board[i].state != ToeState.empty) continue;

      List<ToeData> newBoard = board.map((data) => data.copyWith()).toList();
      newBoard[i] = newBoard[i]
          .copyWith(state: isMaximizingPlayer ? ToeState.x : ToeState.o);
      int score = _miniMax(
        boardState: newBoard,
        isMaximizingPlayer: isMaximizingPlayer,
        depth: 0,
      );

      if (isMaximizingPlayer) {
        if (score > bestScore) {
          bestScore = score;
          bestMoveIndex = i;
        }
      } else {
        if (score < bestScore) {
          bestScore = score;
          bestMoveIndex = i;
        }
      }
    }

    return bestMoveIndex;
  }

  int _miniMax({
    required List<ToeData> boardState,
    required bool isMaximizingPlayer, //* X - is the maximizing player
    required int depth,
  }) {
    //* check gameOver and return the score on terminal state
    final gameState = getCurrentGameState(boardState);
    if (gameState.isGameOver) {
      return switch (gameState) {
        GameState.tie => 0,
        GameState.winX => isMaximizingPlayer ? 1 : -1,
        GameState.winO => isMaximizingPlayer ? -1 : 1,
        _ => throw UnimplementedError(),
      };
    }
    List<int> scores = [];
    for (int i = 0; i < boardState.length; i++) {
      if (boardState[i].state != ToeState.empty) continue;

      List<ToeData> newBoard =
          boardState.map((data) => data.copyWith()).toList();
      newBoard[i] = newBoard[i]
          .copyWith(state: isMaximizingPlayer ? ToeState.x : ToeState.o);

      int score = _miniMax(
        boardState: newBoard,
        isMaximizingPlayer: !isMaximizingPlayer, //opponent
        depth: depth + 1,
      );

      //TODO: USe isolate
      // addGeneratedData(depth, newBoard, score);

      scores.add(score);
    }

    return scores.reduce(isMaximizingPlayer ? math.max : math.min);
  }
}
