import 'package:flutter/material.dart';

import '../models/toe_data.dart';
import 'toe_item_state_view.dart';

class ToeItemView extends StatelessWidget {
  const ToeItemView({
    super.key,
    required this.data,
    required this.onTap,
  });

  final ToeData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const border = BorderSide(color: Colors.black, width: 2);

    const emptyBorder = BorderSide(color: Colors.transparent);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: data.index % 3 != 2 ? border : emptyBorder,
          bottom: data.index < 6 ? border : emptyBorder,
        ),
      ),
      child: ToeItemStateView(
        toeState: data.state,
        onTap: onTap,
      ),
    );
  }
}
