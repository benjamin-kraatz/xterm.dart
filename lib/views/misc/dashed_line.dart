import 'package:d2_flutter_core/d2_flutter_core.dart';
import 'package:flutter/material.dart';

class DashedLineVerticalPainter extends CustomPainter {
  final BuildContext context;
  final Color? color;
  const DashedLineVerticalPainter(this.context, {this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 2, dashSpace = 2, startY = 0;
    final paint = Paint()
      ..color = color ?? context.theme.colorScheme.onSurface
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DashedLineHorizontalPainter extends CustomPainter {
  final BuildContext context;
  const DashedLineHorizontalPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 2, dashSpace = 2, startX = 0;
    final paint = Paint()
      ..color = context.theme.dividerTheme.color ?? context.theme.colorScheme.onSurface.withOpacity(0.25)
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
