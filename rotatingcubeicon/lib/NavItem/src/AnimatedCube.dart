import 'package:flutter/material.dart';
import 'dart:math' as math;

class Cube extends AnimatedWidget {
  final AnimationController controller;
  final Animation animation;

  final Icon frontIcon;
  final Icon topIcon;
  final Color frontColor;
  final Color topColor;
  final double sqrSize;

  Cube({
    Key key,
    this.animation,
    this.controller,
    this.frontColor,
    this.frontIcon,
    this.topColor,
    this.topIcon,
    this.sqrSize,
  }) : super(listenable: animation, key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0001) // add perspective on the z axis
            ..translate(
              0.0,
              math.sin((1 - animation.value) * math.pi / 2) * -(sqrSize / 2),
              math.cos((1 - animation.value) * math.pi / 2) * -(sqrSize / 2),
            )
            ..rotateX((1 - animation.value) * (-math.pi / 2)), // rotation for
            // the top square is opposite to the one on the front square
          child: Container(
            width: sqrSize,
            height: sqrSize,
            color: topColor,
            child: Center(
              child: topIcon,
            ),
          ),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0001) // z axis perspective
            ..translate(
              0.0,
              math.sin(animation.value * math.pi / 2) * (sqrSize / 2),
              math.cos((1 - animation.value) * math.pi / 2) * (sqrSize / 2),
            )
            ..rotateX(animation.value * (math.pi / 2)),
          child: Container(
            width: sqrSize,
            height: sqrSize,
            color: frontColor,
            child: Center(
              child: frontIcon,
            ),
          ),
        ),
      ],
    );
  }
}
