import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class BubblePainter extends CustomPainter {
  BubblePainter({@required List<Color> colors, @required BuildContext context, @required ScrollableState scrollable})
      : _colors = colors,
        _bubbleContext = context,
        _scrollable = scrollable;

  final List<Color> _colors;
  final ScrollableState _scrollable;
  final BuildContext _bubbleContext;

  @override
  void paint(Canvas canvas, Size size) {
    final scrollableBox = _scrollable.context.findRenderObject() as RenderBox; // Scrollable Area
    final scrollableRect = Offset.zero & scrollableBox.size; // Scrollable Area Size
    final bubbleBox = _bubbleContext.findRenderObject() as RenderBox; // Bubble Box

    final origin =
        bubbleBox.localToGlobal(Offset.zero, ancestor: scrollableBox); // Build reference of bubble and scroll area

    final paint = Paint()
      ..shader = ui.Gradient.linear(
        scrollableRect.topCenter,
        scrollableRect.bottomCenter,
        _colors,
        [0.0, 1.0],
        TileMode.clamp,
        // Perform x,y,z position transformation according to the bubble box's relative position to the scrollable area
        Matrix4.translationValues(-origin.dx, -origin.dy, 0).storage,
      );
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) {
    return oldDelegate._scrollable != _scrollable ||
        oldDelegate._colors != _colors ||
        oldDelegate._bubbleContext != _bubbleContext;
  }
}
