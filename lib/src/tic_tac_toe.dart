import 'package:flutter/material.dart';

import 'presentation/game_play.dart';

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GamePlayPage(),
    );
  }
}
