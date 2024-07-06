import 'package:flutter/material.dart';

import '../models/toe_data.dart';

class ToeItemStateView extends StatelessWidget {
  const ToeItemStateView({
    super.key,
    required this.toeState,
    required this.onTap,
  });

  final ToeState toeState;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: switch (toeState) {
          ToeState.o => Text("O"),
          ToeState.x => Text("X"),
          ToeState.win => Text("WIP"),
          _ => const Text(""),
        },
      ),
    );
  }
}
