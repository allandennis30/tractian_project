import 'package:flutter/material.dart';
import 'package:project_tractian/theme/tractian_colors.dart';

class TractianTile extends StatelessWidget {
  const TractianTile({super.key, this.title, this.isChild = false});

  final String? title;
  final bool isChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TractianColor.white,
      padding: EdgeInsets.only(
          left: isChild ? 32.0 : 16.0, top: 16.0, bottom: 16.0, right: 16.0),
      child: Row(
        children: [
          Icon(
            isChild ? Icons.account_tree_rounded : Icons.folder,
          ),
          const SizedBox(width: 10.0),
          const Icon(
            Icons.info,
          ),
          Text(title ?? ''),
        ],
      ),
    );
  }
}
