import 'package:flutter/material.dart';

import '../bloc/ai_player.dart';
import '../bloc/tic_tac_toe_game_engine.dart';
import '../models/toe_data.dart';
import 'ai_move_preview_board.dart';
import 'game_state_view.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({
    super.key,
    required this.engine,
    this.oPlayer,
  });

  final ITicTacToeGameEngine engine;

  /// if Null user will be playing
  final AIPlayer? oPlayer;

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late final engine = widget.engine;

  bool get enabledAI => widget.oPlayer != null;

  int tapCount = 0;

  bool get isXPlayer => tapCount % 2 == 0;
  bool get isOPlayer => tapCount % 2 == 1;

  GameState gameState = GameState.playing;

  ///
  @override
  void initState() {
    super.initState();
    engine.init();
    aiTap();
  }

  @override
  void dispose() {
    engine.dispose();
    super.dispose();
  }

  void aiTap() {
    if (enabledAI) {
      final int? index = widget.oPlayer!.findBestMove(engine.data);
      debugPrint("ai index: $index");
      if (index != null) {
        engine.onXPressed(index: index);
      }
    }
  }

  void updateGameState() {
    gameState = engine.gameState;
    setState(() {});
  }

  void onTap(ToeData data) async {
    if (data.state.isTaken) return;
    widget.oPlayer?.clearGeneratedData();

    if (isXPlayer) {
      engine.onOPressed(index: data.index);
      aiTap();
    } else {
      engine.onOPressed(index: data.index);
    }

    enabledAI ? tapCount += 2 : tapCount++;
    updateGameState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final restartBtn = TextButton(
      onPressed: () {
        engine.init();
        tapCount = 0;
        aiTap();
        updateGameState();
      },
      child: const Text("Restart"),
    );

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: switch (gameState) {
              GameState.tie => const Text("Tie"),
              GameState.winX => const Text("X Win"),
              GameState.winO => const Text("O Win"),
              GameState.playing => GameStateView(
                  board: engine.data,
                  onTap: (int index) {
                    onTap(engine.data.elementAt(index));
                  },
                ),
              _ => Text("Unimplemented State $gameState"),
            },
          ),
          restartBtn,
          AiMovePreview(data: widget.oPlayer?.generatedData ?? []),
        ],
      ),
    );
  }
}
