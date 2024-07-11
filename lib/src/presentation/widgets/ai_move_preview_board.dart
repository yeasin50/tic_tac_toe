import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/presentation/bloc/game_state_mixin.dart';
import 'package:tic_tac_toe/src/presentation/widgets/game_state_view.dart';

import '../models/toe_data.dart';

class AiMovePreview extends StatelessWidget {
  const AiMovePreview({super.key, required this.data});

  final List<GameBoard> data;

  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      child: SingleChildScrollView(
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
                            board:  d.data,
                            score:  d.score,
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
