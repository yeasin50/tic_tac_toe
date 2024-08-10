import 'package:flutter/material.dart';
import 'bloc/ai_player.dart';

import 'bloc/tic_tac_toe_game_engine.dart';
import 'game_board_page.dart';

/// the user will be playing on this page
/// User will be decided if he wants to play with AI or not
///
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///
  void onNavigate(bool enableAi) {
    final route = TickTacToeGameBoard.route(
      engine: TicTacToeGameEngine(),
      oPlayer: enableAi ? AIPlayer() : null,
    );
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final aiButtonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(400, 50),
      shape: const StadiumBorder(),
      backgroundColor: Colors.deepPurpleAccent,
      foregroundColor: Colors.white,
    );
    final humanButtonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(400, 50),
      shape: const StadiumBorder(),
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic-Tac-Toe"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Play Mode",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: aiButtonStyle,
                onPressed: () => onNavigate(true),
                label: const Text("Play with AI"),
                icon: const Icon(Icons.computer),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: humanButtonStyle,
                onPressed: () => onNavigate(false),
                label: const Text("Play with Friend"),
                icon: const Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
