import 'package:flutter/material.dart';
import 'package:flutter_websocket_demo/components/bubble_painter.dart';

@immutable
class BubbleBackground extends StatelessWidget {
  BubbleBackground({@required this.colors, this.child, Key key}) : super(key: key);
  final List<Color> colors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(colors: colors, context: context, scrollable: Scrollable.of(context)),
      child: child,
    );
  }
}
