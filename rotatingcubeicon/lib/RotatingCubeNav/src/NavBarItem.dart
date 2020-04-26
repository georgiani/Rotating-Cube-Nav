import 'package:flutter/material.dart';
import 'AnimatedCube.dart';

/// This is the widget that controls how the
/// [AnimatedCube] behaves.
class NavBarItem extends StatefulWidget {
  /// The icon that appears on the top square of
  /// the cube.
  final Icon frontSquareIcon;
  /// The icon that appears on the front square of
  /// the cube.
  final Icon topSquareIcon;
  final Color frontSquareColor;
  final Color topSquareColor;
  /// The size of the faces of [AnimatedCube].
  final double sqrSize;
  /// The curve that the [rotateAnim] takes.
  final Curve cubeCurve;
  double flip;

  NavBarItem({
    this.frontSquareColor,
    this.frontSquareIcon,
    this.topSquareColor,
    this.topSquareIcon,
    this.cubeCurve,
    this.sqrSize,
    this.flip,
  }) : assert(flip == -1 || flip == 1);

  _NavBarItemState _widgetState;

  @override
  _NavBarItemState createState() {
    _widgetState = _NavBarItemState();
    return _widgetState;
  }

  /// Method used to return the cube
  /// to its original position.
  void rotateBack() {
    _widgetState.rotateBack();
  }

  /// Method used to start the animation.
  void rotateForward() {
    _widgetState.rotateForward();
  }
}

class _NavBarItemState extends State<NavBarItem>
    with SingleTickerProviderStateMixin {

  AnimationController controller; // explicit animation
  // so i need to use a controller to manage how the
  // animation behaves in different situations
  Animation rotateAnim; // the actual animation


  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(milliseconds: 500), 
      vsync: this,
    );

    // I transition from 0 to 1 and map the tween to 
    // radians in the AnimatedCube widget
    rotateAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        // rotateAnim is driven by the controller
        // that I previously instantiated
        parent: controller,
        // and this is the curve that the animation
        // has
        curve: widget.cubeCurve ?? Curves.elasticInOut,
      ),
    );

    /// This is used at the start for mentioning
    /// which of the cubes should be in an ON state.
    /// This should 1 on the cube that has the index
    /// equal to the initialPage.
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
    // if the animation is not running
    if (controller.status != AnimationStatus.forward &&
        controller.status != AnimationStatus.reverse) {
      // and the last flip was backwards (meaning that the widget is
      // in the right position)
      if (widget.flip == -1) {
        // then start the animation
        controller.forward(); 
        // and switch the last flipping position
        widget.flip = -widget.flip;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Cube(
      animation: rotateAnim, // the animated widget does not need
      // control over it
      frontSquareColor: widget.frontSquareColor,
      frontSquareIcon: widget.frontSquareIcon,
      topSquareColor: widget.topSquareColor,
      topSquareIcon: widget.topSquareIcon,
      sqrSize: widget.sqrSize,
    );
  }
}
