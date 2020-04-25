import 'package:flutter/material.dart';
import 'AnimatedCube.dart';

class NavBarItem extends StatefulWidget {
  final Icon frontIcon;
  final Icon topIcon;
  final Color frontColor;
  final Color topColor;
  final double sqrSize;
  double flip;

  NavBarItem({
    this.frontColor,
    this.frontIcon,
    this.topColor,
    this.topIcon,
    this.sqrSize,
    this.flip,
  }) : assert(flip == -1 || flip == 1);

  _NavBarItemState _widgetState;

  @override
  _NavBarItemState createState() {
    _widgetState = _NavBarItemState();
    return _widgetState;
  }

  void rotateBack() {
    _widgetState.rotateBack();
  }

  void rotateForward() {
    _widgetState.rotateForward();
  }
}

class _NavBarItemState extends State<NavBarItem>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation rotateAnim;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    rotateAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.elasticInOut,
      ),
    );

    if (widget.flip == 1) {
      controller.forward();
    }

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void rotateBack() {
    if (controller.status != AnimationStatus.forward &&
        controller.status != AnimationStatus.reverse) {
      if (widget.flip == 1) {
        controller.reverse();
        widget.flip = -widget.flip;
      }
    }
  }

  void rotateForward() {
    if (controller.status != AnimationStatus.forward &&
        controller.status != AnimationStatus.reverse) {
      if (widget.flip == -1) {
        controller.forward();
        widget.flip = -widget.flip;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Cube(
      animation: rotateAnim, // the animation to do
      controller: controller, // the thing that controls the animation
      frontColor: widget.frontColor,
      frontIcon: widget.frontIcon,
      topColor: widget.topColor,
      topIcon: widget.topIcon,
      sqrSize: widget.sqrSize,
    );
  }
}
