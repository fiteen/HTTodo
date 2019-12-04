import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final Color color;

  GradientBackground({@required this.child, @required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: getColorList(color),
        )
      ),
      curve: Curves.linear,
      child: child,
      duration: Duration(microseconds: 500),
    );
  }

  List<Color> getColorList(Color color) {
    if (color is MaterialColor) {
      return [
        color[300],
        color[600],
        color[700],
        color[900]
      ];
    } else {
      return List<Color>.filled(4, color);
    }
  }
}