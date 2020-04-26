import 'package:flutter/material.dart';
import 'NavBarItem.dart';

class RotatingCubeNav extends StatelessWidget {
  /// The items of the navigation bar. See [NavBarItem] definition
  /// to see how this is used.
  final List<NavBarItem> items;
  final int numberOfItems;

  /// If this is not null then this widget will also build
  /// a PageView which contains the pages listed in here.
  final List<dynamic> pages;
  final int initialPage;

  /// Specify how the items should be aligned in the navigation bar.
  final MainAxisAlignment rowCubesAlignment;

  /// Specify the curve of the transition between the pages.
  final Curve pageTransitionCurve;

  /// Specify the duration of the transition between the pages.
  final Duration pageTransitionDuration;

  /// Position of the navigation bar
  final Alignment bottomNavBarAlignment;
  // The padding for the navigation bar.
  final EdgeInsetsGeometry bottomNavBarPadding;

  RotatingCubeNav({
    @required this.items,
    @required this.numberOfItems,
    this.pages,
    this.pageTransitionCurve,
    this.initialPage,
    this.pageTransitionDuration,
    this.bottomNavBarAlignment,
    this.rowCubesAlignment,
    this.bottomNavBarPadding,
  });

  PageController _controller;

  void _rotateCubeAtPosition(int index) {
    if (index != navBarIndex) {
      items[index].rotateForward();
      items[navBarIndex].rotateBack();
      navBarIndex = index;

      if (pages != null) {
        _controller.animateToPage(
          index,
          duration: pageTransitionDuration ?? Duration(milliseconds: 500),
          curve: pageTransitionCurve ?? Curves.easeIn,
        );
      }
    }
  }

  int navBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    _controller = PageController(
      initialPage: initialPage ?? 0,
    );

    List tapCubes = items
        .map(
          (c) => GestureDetector(
            onTap: () => this._rotateCubeAtPosition(items.indexOf(c)),
            child: c,
          ),
        )
        .toList();

    return pages != null
        ? Stack(
            children: [
              PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: this.numberOfItems,
                controller: _controller,
                itemBuilder: (pageCtx, idx) {
                  return pages[idx];
                },
                // onPageChanged: (value) {
                //   this._rotateCubeAtPosition(value);
                // },
                // TODO: implement onPageChanged when the user scrolls
              ),
              Padding(
                padding:
                    bottomNavBarPadding ?? EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Align(
                  alignment: bottomNavBarAlignment ?? Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment:
                        rowCubesAlignment ?? MainAxisAlignment.center,
                    children: tapCubes,
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: rowCubesAlignment ?? MainAxisAlignment.center,
            children: tapCubes,
          );
  }
}
