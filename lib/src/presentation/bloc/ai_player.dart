import 'package:flutter/foundation.dart';

import '../models/toe_data.dart';
import 'game_state_mixin.dart';
import 'dart:math' as math;

import 'tic_tac_toe_game_engine.dart';

/// hold the stage of the game
class AIGameBoardData {
  const AIGameBoardData({
    required this.dept,
    required this.parent,
    required this.board,
    required this.score,
    this.nodes = const [],
  });

  final int dept;
  final int? parent;
  final List<ToeData> board;
  final int score;
  final List<AIGameBoardData> nodes;
}

/// decide the best possible move for the player.
///  [List<ToeData>] is the current board state which will length of 9
///   X -
///   O -
/// FIXME: [isMaximizingPlayer==true] isnt tested yet
class AIPlayer with GameStateMixin {
  Future<int?> findBestMove(
    List<ToeData> board, {
    bool isMaximizingPlayer = false,
  }) async {
    final params = [board, isMaximizingPlayer];
    final bestMove = await compute(_findBestMove, params);
    return bestMove;
  }

  int? _findBestMove(List data) {
    final board = data[0] as List<ToeData>;
    final isMaximizingPlayer = data[1] as bool;
    assert(board.length == 9, "boardState length should be 9");

    int? bestMoveIndex;
    int bestScore = isMaximizingPlayer ? -100000 : 100000;

    for (int i = 0; i < board.length; i++) {
      if (board[i].state != ToeState.empty) continue;

      List<ToeData> newBoard = board.map((data) => data.copyWith()).toList();
      newBoard[i] = newBoard[i]
          .copyWith(state: isMaximizingPlayer ? ToeState.x : ToeState.o);

      int score = _miniMax(
        board: newBoard,
        isMaximizingPlayer: !isMaximizingPlayer,
        depth: 0,
      );

      if (score > bestScore && isMaximizingPlayer) {
        bestScore = score;
        bestMoveIndex = i;
      } else if (score < bestScore && !isMaximizingPlayer) {
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

    int bestScore = isMaximizingPlayer ? -100000 : 100000;
    for (int i = 0; i < board.length; i++) {
      if (board[i].state != ToeState.empty) continue;

      List<ToeData> newBoard = board.map((data) => data.copyWith()).toList();
      newBoard[i] = newBoard[i].copyWith(
        state: isMaximizingPlayer ? ToeState.x : ToeState.o,
      );

      int score = _miniMax(
          board: newBoard,
          isMaximizingPlayer: !isMaximizingPlayer,
          depth: depth + 1);
      bestScore = isMaximizingPlayer
          ? math.max(bestScore, score)
          : math.min(bestScore, score);
    }
    return bestScore;
  }
}
