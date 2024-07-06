import 'package:flutter/material.dart';

import '../bloc/tic_tac_toe_game_engine.dart';
import '../models/toe_data.dart';
import 'toe_item_view.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key, required this.engine});

  final ITicTacToeGameEngine engine;

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late final engine = widget.engine;

  int tapCount = 0;

  bool get isXPlayer => tapCount % 2 == 0;
  bool get isOPlayer => tapCount % 2 == 1;

  GameState gameState = GameState.playing;

  ///
  @override
  void initState() {
    engine.init();
    super.initState();
  }

  @override
  void dispose() {
    engine.dispose();
    super.dispose();
  }

  void updateGameState() {
    gameState = engine.gameState;
    setState(() {});
  }

  void onTap(ToeData data) {
    if (data.state.isTaken) return;

    if (isXPlayer) {
      engine.onXPressed(index: data.index);
    } else {
      engine.onOPressed(index: data.index);
    }
    tapCount++;
    updateGameState();
  }

  @override
  Widget build(BuildContext context) {
    final restartBtn = TextButton(
      onPressed: () {
        engine.init();
        tapCount = 0;
        updateGameState();
      },
      child: const Text("Restart"),
    );

    return switch (gameState) {
      GameState.tie => const Text("Tie"),
      GameState.winX => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("X Win"),
            restartBtn,
          ],
        ),
      GameState.winO => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("O Win"),
            restartBtn,
          ],
        ),
      GameState.playing => GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(24),
          shrinkWrap: true,
          children: widget.engine.data
              .map(
                (e) => ToeItemView(
                  data: e,
                  onTap: () {
                    onTap(e);
                  },
                ),
              )
              .toList(),
        ),
      _ => Text("Unimplemented State $gameState"),
    };
  }
}
