import 'package:flutter/material.dart';
import 'package:rotatingcubeicon/RotatingCubeNav/RotatingCubeNavBar.dart';
import 'globals.dart';

void main() {
  runApp(ScreenForNavBS());
}

class ScreenForNavBS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenForNav(),
    );
  }
}

class ScreenForNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.yellowCrayola,
      body: Container(
        child: RotatingCubeNav(
          numberOfItems: 3,
          items: [
            NavBarItem(
              frontColor: Colors.yellow,
              topColor: Colors.yellow[300],
              frontIcon: Icon(Icons.flag),
              topIcon: Icon(Icons.outlined_flag),
              sqrSize: 50,
              flip: 1,
            ),
            NavBarItem(
              frontColor: Colors.orange,
              topColor: Colors.orange[300],
              frontIcon: Icon(Icons.add_circle),
              topIcon: Icon(Icons.add_circle_outline),
              sqrSize: 50,
              flip: -1,
            ),
            NavBarItem(
              frontColor: Colors.indigo,
              topColor: Colors.indigo[300],
              frontIcon: Icon(Icons.people),
              topIcon: Icon(Icons.people_outline),
              sqrSize: 50,
              flip: -1,
            ),
          ],
          pages: [
            Scaffold(
              backgroundColor: Global.redPurple,
              body: Center(
                child: Text(
                  "Page 1",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Global.orangeYellow,
              body: Center(
                child: Text(
                  "Page 2",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.yellowAccent,
              body: Center(
                child: Text(
                  "Page 3",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
