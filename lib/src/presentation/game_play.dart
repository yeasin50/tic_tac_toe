import 'package:flutter/material.dart';
import 'bloc/ai_player.dart';
import 'widgets/game_board.dart';

import 'bloc/tic_tac_toe_game_engine.dart';

/// the user will be playing on this page
class GamePlayPage extends StatefulWidget {
  const GamePlayPage({super.key});

  @override
  State<GamePlayPage> createState() => _GamePlayPageState();
}

class _GamePlayPageState extends State<GamePlayPage> {
  final ITicTacToeGameEngine _ticTacToeGameEngine = TicTacToeGameEngine();
  final AIPlayer aiPlayer = AIPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic-Tac-Toe"),
      ),
      body: Center(
        child: GameBoard(
          engine: _ticTacToeGameEngine,
          oPlayer: aiPlayer,
        ),
      ),
    );
  }
}
