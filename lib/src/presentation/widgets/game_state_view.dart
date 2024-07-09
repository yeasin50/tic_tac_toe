import 'package:flutter/material.dart';

import '../models/toe_data.dart';
import 'toe_item_view.dart';

class GameStateView extends StatelessWidget {
  const GameStateView({
    super.key,
    required this.board,
    this.score,
    this.onTap,
  });

  final List<ToeData> board;
  final int? score;
  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    assert(board.length == 9, "boardState length should be 9");
    return Container(
      decoration: score != null
          ? BoxDecoration(
              border: Border.all(color: Colors.grey),
            )
          : null,
      child: Column(
        children: [
          for (int i = 0; i < 3; i++)
            Row(
              children: [
                for (int j = 0; j < 3; j++)
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ToeItemView(
                        data: board[i * 3 + j],
                        onTap: () => onTap?.call(i * 3 + j),
                      ),
                    ),
                  ),
              ],
            ),
          if (score != null) ...[
            const SizedBox(height: 10),
            Text("Score: $score"),
          ]
        ],
      ),
    );
  }
}
