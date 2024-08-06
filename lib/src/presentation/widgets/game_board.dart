import 'package:flutter/material.dart';

import '../bloc/ai_player.dart';
import '../bloc/tic_tac_toe_game_engine.dart';
import '../models/toe_data.dart';
import 'game_state_view.dart';

/// Create a Tic-Tac-Toe Board
/// [engine] should be an instance of [TicTacToeGameEngine]
/// [oPlayer] should be an instance of [AIPlayer]
/// if [oPlayer] is Null user will be playing
///
///```dart
/// final route =TickTacToeGameBoard.route(
///   engine: TicTacToeGameEngine(),
///   oPlayer: enableAi ? AIPlayer() : null,
/// );
///
/// Navigator.push(context, route);
///
///```
class TickTacToeGameBoard extends StatefulWidget {
  const TickTacToeGameBoard._({
    required this.engine,
    this.oPlayer,
  });

  final ITicTacToeGameEngine engine;

  /// if Null user will be playing
  final AIPlayer? oPlayer;

  static MaterialPageRoute route({
    required ITicTacToeGameEngine engine,
    AIPlayer? oPlayer,
  }) {
    return MaterialPageRoute(
      builder: (context) =>
          TickTacToeGameBoard._(engine: engine, oPlayer: oPlayer),
    );
  }

  @override
  State<TickTacToeGameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<TickTacToeGameBoard> {
  late final engine = widget.engine;

  bool get enabledAI => widget.oPlayer != null;
  bool isXPlayer = true;
  GameState gameState = GameState.playing;

  ///
  @override
  void initState() {
    super.initState();
    engine.init();
  }

  @override
  void dispose() {
    engine.dispose();
    super.dispose();
  }

  Future<void> aiTap() async {
    final int? index = await widget.oPlayer!.findBestMove(engine.data);

    if (index != null) {
      engine.onOPressed(index: index);
      isXPlayer = true;
      updateGameState();
    }
  }

  void updateGameState() {
    gameState = engine.gameState;
    setState(() {});
  }

  void onTap(ToeData data) async {
    if (data.state.isTaken || gameState.isGameOver) return;
    widget.oPlayer?.clearGeneratedData();

    if (isXPlayer) {
      isXPlayer = false;
      engine.onXPressed(index: data.index);
      setState(() {});

      if (enabledAI) await aiTap();
    } else if (isXPlayer == false && enabledAI == false) {
      engine.onOPressed(index: data.index);
      isXPlayer = true;
    }

    updateGameState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final restartBtn = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurpleAccent.withAlpha(120),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(32),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      onPressed: () {
        engine.init();
        isXPlayer = true;
        updateGameState();
      },
      child: const Text(
        "Restart",
        style: TextStyle(fontSize: 20),
      ),
    );

    final gameOverTextStyle =
        Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Colors.white,
            );
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic-Tac-Toe ${enabledAI ? "-with AI" : ""}"),
      ),
      body: Center(
        child: Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: ColoredBox(
              color: gameState.isGameOver
                  ? Colors.black.withOpacity(0.5)
                  : Colors.transparent,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  GameStateView(
                    board: engine.data,
                    onTap: (int index) {
                      onTap(engine.data.elementAt(index));
                    },
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        switch (gameState) {
                          GameState.tie => Text(
                              "Tie",
                              style: gameOverTextStyle,
                            ),
                          GameState.winX => Text(
                              "X Win",
                              style: gameOverTextStyle,
                            ),
                          GameState.winO => Text(
                              "O Win",
                              style: gameOverTextStyle,
                            ),
                          _ => const SizedBox(),
                        },
                        const SizedBox(height: 24),
                        if (gameState.isGameOver)
                          restartBtn
                        else if (enabledAI && isXPlayer == false)
                          const SizedBox.square(
                            dimension: 100,
                            child: CircularProgressIndicator(),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
