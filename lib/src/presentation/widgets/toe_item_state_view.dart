import 'package:flutter/material.dart';

import '../models/toe_data.dart';

class ToeItemStateView extends StatelessWidget {
  const ToeItemStateView({
    super.key,
    required this.toeState,
    this.onTap,
  });

  final ToeState toeState;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: switch (toeState) {
          ToeState.x => const FittedBox(child: Icon(Icons.close)),
          ToeState.o => const FittedBox(child: Icon(Icons.circle_outlined)),
          ToeState.win => Text("WIP"),
          _ => const Text(""),
        },
      ),
    );
  }
}
