import 'package:flutter/material.dart';

import '../../theme/tractian_colors.dart';

enum LineType {
  horizontal(Size(100, 2)),
  vertical(Size(2, 100)),
  fullHeightVertical(Size(2, double.infinity));

  final Size size;
  const LineType(this.size);
}

class TractianLinePainter extends CustomPainter {
  final LineType lineType;

  TractianLinePainter({required this.lineType});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = TractianColor.gray200
      ..strokeWidth = 2;

    switch (lineType) {
      case LineType.horizontal:
        canvas.drawLine(Offset(0, size.height / 2),
            Offset(size.width, size.height / 2), paint);
        break;
      case LineType.vertical:
        canvas.drawLine(Offset(size.width / 2, 0),
            Offset(size.width / 2, size.height), paint);
        break;
      case LineType.fullHeightVertical:
        canvas.drawLine(Offset(size.width / 2, 0),
            Offset(size.width / 2, size.height), paint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
