import 'package:flutter/foundation.dart';

import '../models/toe_data.dart';

enum GameState {
  // idle,
  playing,
  winX,
  winO,
  tie
}

abstract class ITicTacToeGameEngine {
  void init();

  void dispose();

  void onXPressed({required int index});

  void onOPressed({required int index});

  GameState get gameState;

  List<ToeData> get data;
}

class TicTacToeGameEngine extends ITicTacToeGameEngine {
  final boardSize = 3;
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

  List<ToeData> _getRow(int rowIndex) {
    return data.sublist(rowIndex * boardSize, rowIndex * boardSize + boardSize);
  }

  List<ToeData> _getColum(int colIndex) {
    return data.where((e) => e.index % boardSize == colIndex).toList();
  }

  List<ToeData> get _topLeftToBottomRight => [_data[0], _data[4], _data[8]];
  List<ToeData> get _topRightToBottomLeft => [_data[2], _data[4], _data[6]];

  List<ToeData> _getDiagonal(bool topLeftToBottomRight) {
    if (topLeftToBottomRight) {
      ///FIXME:  use dynamic/create algo to solve it instead of fixed index

      return _topLeftToBottomRight;
    } else {
      return _topRightToBottomLeft;
    }
  }

  bool _allSame(List<ToeData> cells) {
    return cells.every(
      (element) =>
          element.state != ToeState.empty && element.state == cells[0].state,
    );
  }

  @override
  GameState get gameState {
    // rows
    for (int i = 0; i < boardSize; i++) {
      final rowData = _getRow(i);
      if (_allSame(rowData)) {
        return rowData.first.state == ToeState.o
            ? GameState.winO
            : GameState.winX;
      }
    }

    ///for column check
    for (int i = 0; i < boardSize; i++) {
      final colData = _getColum(i);
      if (_allSame(colData)) {
        return colData.first.state == ToeState.o
            ? GameState.winO
            : GameState.winX;
      }
    }

    ///for diagonal check topLeftToBottomRight
    final topLeftToBottomRightData = _getDiagonal(true);
    if (_allSame(topLeftToBottomRightData)) {
      return topLeftToBottomRightData.first.state == ToeState.o
          ? GameState.winO
          : GameState.winX;
    }

    ///for diagonal check topRightToBottomLeft
    final topRightToBottomLeftData = _getDiagonal(false);
    debugPrint(
        "topRightToBottomLeftData ${topRightToBottomLeftData.map((e) => e.state)}");
    if (_allSame(topRightToBottomLeftData)) {
      return topRightToBottomLeftData.first.state == ToeState.o
          ? GameState.winO
          : GameState.winX;
    }

    // when all cells are filled, it will be a tie
    if (_data.every((element) => element.state != ToeState.empty)) {
      return GameState.tie;
    }

    return GameState.playing;
  }

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
