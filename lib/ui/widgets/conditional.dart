import 'package:flutter/material.dart';

class Conditional extends StatelessWidget {
  final bool condition;
  final Widget ifTrue;
  final Widget ifFalse;

  const Conditional({Key key, this.condition, this.ifTrue, this.ifFalse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return ifTrue;
    } else {
      return ifFalse;
    }
  }
}
