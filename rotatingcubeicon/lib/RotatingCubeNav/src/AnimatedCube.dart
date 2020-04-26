import 'package:flutter/material.dart';
import 'dart:math' as math;

class Cube extends AnimatedWidget {
  final Icon frontSquareIcon;
  final Icon topSquareIcon;
  final Color frontSquareColor;
  final Color topSquareColor;
  final double sqrSize;

  Cube({
    Key key,
    Animation<double> animation,
    this.frontSquareColor,
    this.frontSquareIcon,
    this.topSquareColor,
    this.topSquareIcon,
    this.sqrSize,
  }) : super(listenable: animation, key: key);

  @override
  Widget build(BuildContext context) {
    Animation<double> _anim = listenable;
    return Stack(
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0001) // add perspective on the z axis
            ..translate(
              0.0,
              math.sin((1 - _anim.value) * math.pi / 2) * -(sqrSize / 2),
              math.cos((1 - _anim.value) * math.pi / 2) * -(sqrSize / 2),
            )
            ..rotateX((1 - _anim.value) * (-math.pi / 2)), // rotation for
            // the top square is opposite to the one on the front square
          child: Container(
            width: sqrSize,
            height: sqrSize,
            color: topSquareColor,
            child: Center(
              child: topSquareIcon,
            ),
          ),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0001) // z axis perspective
            ..translate(
              0.0,
              math.sin(_anim.value * math.pi / 2) * (sqrSize / 2),
              math.cos((1 - _anim.value) * math.pi / 2) * (sqrSize / 2),
            )
            ..rotateX(_anim.value * (math.pi / 2)),
          child: Container(
            width: sqrSize,
            height: sqrSize,
            color: frontSquareColor,
            child: Center(
              child: frontSquareIcon,
            ),
          ),
        ),
      ],
    );
  }
}
