import 'package:tic_tac_toe/src/presentation/bloc/tic_tac_toe_game_engine.dart';

import '../models/toe_data.dart';

/// reduce and reuse the game logic
/// Check the current game state
mixin GameStateMixin {
  final boardSize = 3;

  GameState getCurrentGameState(List<ToeData> data) {
    // rows
    for (int i = 0; i < boardSize; i++) {
      final rowData = _getRow(data: data, rowIndex: i);
      if (_allSame(rowData)) {
        return rowData.first.state == ToeState.o
            ? GameState.winO
            : GameState.winX;
      }
    }

    ///for column check
    for (int i = 0; i < boardSize; i++) {
      final colData = _getColum(data: data, colIndex: i);
      if (_allSame(colData)) {
        return colData.first.state == ToeState.o
            ? GameState.winO
            : GameState.winX;
      }
    }

    ///for diagonal check topLeftToBottomRight
    final topLeftToBottomRightData =
        _getDiagonal(topLeftToBottomRight: true, data: data);
    if (_allSame(topLeftToBottomRightData)) {
      return topLeftToBottomRightData.first.state == ToeState.o
          ? GameState.winO
          : GameState.winX;
    }

    ///for diagonal check topRightToBottomLeft
    final topRightToBottomLeftData =
        _getDiagonal(topLeftToBottomRight: false, data: data);

    if (_allSame(topRightToBottomLeftData)) {
      return topRightToBottomLeftData.first.state == ToeState.o
          ? GameState.winO
          : GameState.winX;
    }

    // when all cells are filled, it will be a tie
    if (data.every((element) => element.state != ToeState.empty)) {
      return GameState.tie;
    }

    return GameState.playing;
  }

  List<ToeData> _getRow({required List<ToeData> data, required int rowIndex}) =>
      data.sublist(
        rowIndex * boardSize,
        rowIndex * boardSize + boardSize,
      );

  List<ToeData> _getColum({
    required List<ToeData> data,
    required int colIndex,
  }) =>
      data.where((e) => e.index % boardSize == colIndex).toList();

  /// can we remove fixed index and create separate algorithm
  List<ToeData> _topLeftToBottomRight(List<ToeData> data) =>
      [data[0], data[4], data[8]];
  List<ToeData> _topRightToBottomLeft(List<ToeData> data) =>
      [data[2], data[4], data[6]];

  List<ToeData> _getDiagonal({
    required bool topLeftToBottomRight,
    required List<ToeData> data,
  }) {
    return topLeftToBottomRight
        ? _topLeftToBottomRight(data)
        : _topRightToBottomLeft(data);
  }

  bool _allSame(List<ToeData> cells) {
    return cells.every(
      (element) =>
          element.state != ToeState.empty && //
          element.state == cells[0].state,
    );
  }
}
