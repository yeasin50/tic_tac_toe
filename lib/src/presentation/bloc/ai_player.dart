import '../models/toe_data.dart';
import 'game_state_mixin.dart';
import 'dart:math' as math;

import 'tic_tac_toe_game_engine.dart';

/// decide the best possible move for the player.
///  [List<ToeData>] is the current board state which will length of 9
///   X -
///   O -
class AIPlayer with GameStateMixin {
  int? findBestMove(List<ToeData> board, {bool isMaximizingPlayer = false}) {
    assert(board.length == 9, "boardState length should be 9");

    int? bestMoveIndex;
    int bestScore = -100000;

    //
    for (int i = 0; i < board.length; i++) {
      if (board[i].state != ToeState.empty) continue;

      List<ToeData> newBoard = board.map((data) => data.copyWith()).toList();
      newBoard[i] = newBoard[i].copyWith(state: ToeState.x);

      int score = _miniMax(
        board: newBoard,
        isMaximizingPlayer: false,
        depth: 0,
      );

      if (score > bestScore) {
        bestScore = score;
        bestMoveIndex = i;
      }
    }

    return bestMoveIndex;
  }

  int _miniMax({
    required List<ToeData> board,
    required bool isMaximizingPlayer,
    required int depth,
  }) {
    //* check gameOver and return the score on terminal state
    final gameState = getCurrentGameState(board);
    if (gameState.isGameOver) {
      return switch (gameState) {
        GameState.tie => 0,
        GameState.winX => 1,
        GameState.winO => -1,
        _ => throw UnimplementedError(),
      };
    }

    if (isMaximizingPlayer) {
      int bestScore = -100000;
      for (int i = 0; i < board.length; i++) {
        if (board[i].state != ToeState.empty) continue;

        List<ToeData> newBoard = board.map((data) => data.copyWith()).toList();
        newBoard[i] = newBoard[i].copyWith(state: ToeState.x);

        int score = _miniMax(
            board: newBoard, isMaximizingPlayer: false, depth: depth + 1);
        bestScore = math.max(bestScore, score);
      }
      return bestScore;
    } else {
      int bestScore = 100000;
      for (int i = 0; i < board.length; i++) {
        if (board[i].state != ToeState.empty) continue;

        List<ToeData> newBoard = board.map((data) => data.copyWith()).toList();
        newBoard[i] = newBoard[i].copyWith(state: ToeState.o);

        int score = _miniMax(
            board: newBoard, isMaximizingPlayer: true, depth: depth + 1);
        bestScore = math.min(bestScore, score);
      }
      return bestScore;
    }
  }
}
