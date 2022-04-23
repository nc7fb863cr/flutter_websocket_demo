import 'package:flutter/material.dart';

class DismissibleScope extends StatelessWidget {
  DismissibleScope({@required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => FocusScope.of(context).unfocus(), child: child);
  }
}
