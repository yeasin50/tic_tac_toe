import 'package:flutter/material.dart';

import '../bloc/tic_tac_toe_game_engine.dart';

class WinnerCrossGridView extends StatefulWidget {
  const WinnerCrossGridView({
    super.key,
    required this.currentState,
    this.onRestartTap,
  });

  // overLay the winner cross on the board
  final CurrentGameState currentState;

  final VoidCallback? onRestartTap;

  @override
  State<WinnerCrossGridView> createState() => _WinnerCrossGridViewState();
}

class _WinnerCrossGridViewState extends State<WinnerCrossGridView> {
  GameState get gameState => widget.currentState.gameState;

  @override
  Widget build(BuildContext context) {
    final gameOverTextStyle = Theme.of(context).textTheme.headlineLarge!.copyWith(
          color: Colors.white,
        );
    return widget.currentState.winnerLine == null
        ? const SizedBox()
        : CustomPaint(
            painter: LinePainter(
              line: widget.currentState.winnerLine!,
            ),
            child: Center(
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent.withAlpha(120),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(32),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onPressed: widget.onRestartTap,
                      child: const Text(
                        "Restart",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                ],
              ),
            ),
          );
  }
}

class LinePainter extends CustomPainter {
  const LinePainter({required this.line});

  final (int, int, int, int) line;

  @override
  void paint(Canvas canvas, Size size) {
    double boxSize = size.width / 3;
    final gap = boxSize / 2;
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 25
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(boxSize * line.$1 + gap, boxSize * line.$2 + gap),
      Offset(boxSize * line.$3 - gap, boxSize * line.$4 + gap),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
