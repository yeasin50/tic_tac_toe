import 'package:tic_tac_toe/src/presentation/bloc/tic_tac_toe_game_engine.dart';

import '../models/toe_data.dart';

class GameBoard {
  const GameBoard({
    required this.data,
    this.score,
    this.depth,
  });

  final List<ToeData> data;
  final int? score;
  final int? depth;
}

/// reduce and reuse the game logic
/// Check the current game state
mixin GameStateMixin {
  final boardSize = 3;

  CurrentGameState getCurrentGameState(List<ToeData> data) {
    // rows
    for (int i = 0; i < boardSize; i++) {
      final rowData = _getRow(data: data, rowIndex: i);
      if (_allSame(rowData)) {
        final winner = rowData.first.state == ToeState.o ? GameState.winO : GameState.winX;
        return CurrentGameState(
          gameState: winner,
          winnerLine: (0, i, 3, i),
        );
      }
    }

    ///for column check
    for (int i = 0; i < boardSize; i++) {
      final colData = _getColum(data: data, colIndex: i);
      if (_allSame(colData)) {
        final winner = colData.first.state == ToeState.o ? GameState.winO : GameState.winX;
        return CurrentGameState(
          gameState: winner,
          winnerLine: (i, 0, i + 1, 2),
        );
      }
    }

    ///for diagonal check topLeftToBottomRight
    final topLeftToBottomRightData = _getDiagonal(topLeftToBottomRight: true, data: data);
    if (_allSame(topLeftToBottomRightData)) {
      return CurrentGameState(
        gameState: topLeftToBottomRightData.first.state == ToeState.o ? GameState.winO : GameState.winX,
        winnerLine: (0, 0, 3, 2),
      );
    }

    ///for diagonal check topRightToBottomLeft
    final topRightToBottomLeftData = _getDiagonal(topLeftToBottomRight: false, data: data);

    if (_allSame(topRightToBottomLeftData)) {
      return CurrentGameState(
        gameState: topRightToBottomLeftData.first.state == ToeState.o ? GameState.winO : GameState.winX,
        winnerLine: (2, 0, 1, 2),
      );
    }

    // when all cells are filled, it will be a tie
    if (data.every((element) => element.state != ToeState.empty)) {
      return const CurrentGameState(gameState: GameState.tie);
    }

    return const CurrentGameState(gameState: GameState.playing);
  }

  List<ToeData> _getRow({required List<ToeData> data, required int rowIndex}) => data.sublist(
        rowIndex * boardSize,
        rowIndex * boardSize + boardSize,
      );

  List<ToeData> _getColum({
    required List<ToeData> data,
    required int colIndex,
  }) =>
      data.where((e) => e.index % boardSize == colIndex).toList();

  /// can we remove fixed index and create separate algorithm
  List<ToeData> _topLeftToBottomRight(List<ToeData> data) => [data[0], data[4], data[8]];
  List<ToeData> _topRightToBottomLeft(List<ToeData> data) => [data[2], data[4], data[6]];

  List<ToeData> _getDiagonal({
    required bool topLeftToBottomRight,
    required List<ToeData> data,
  }) {
    return topLeftToBottomRight ? _topLeftToBottomRight(data) : _topRightToBottomLeft(data);
  }

  bool _allSame(List<ToeData> cells) {
    return cells.every(
      (element) =>
          element.state != ToeState.empty && //
          element.state == cells[0].state,
    );
  }

  ///* Track the minimax algorithm
  ///* return dept and board
  final List<GameBoard> _generatedData = [];
  List<GameBoard> get generatedData => _generatedData;

  void addGeneratedData(int depth, List<ToeData> data, int score) {
    _generatedData.add(GameBoard(
      data: data,
      depth: depth,
      score: score,
    ));
  }

  void clearGeneratedData() => _generatedData.clear();
}
