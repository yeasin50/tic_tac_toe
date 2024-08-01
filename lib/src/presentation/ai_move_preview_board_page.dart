import 'package:flutter/material.dart';

import 'bloc/game_state_mixin.dart';
import 'widgets/game_state_view.dart';

///  preview the possibility move of AI
class AiMovePreviewPage extends StatelessWidget {
  const AiMovePreviewPage._({required this.data});

  final List<GameBoard> data;

  static MaterialPageRoute route({required List<GameBoard> data}) {
    return MaterialPageRoute(
      builder: (context) => AiMovePreviewPage._(data: data),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (final d in data)
              Row(
                children: [
                  Text("Depth: ${d.depth}"),
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        SizedBox(
                          width: 120,
                          child: GameStateView(
                            board: d.data,
                            score: d.score,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
