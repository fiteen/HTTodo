import 'package:flutter/material.dart';

class TodoBadge extends StatelessWidget {
  final int codePoint;
  final String id;
  final Color color;
  final Color outlineColor;
  final double size;

  TodoBadge({
    @required this.codePoint,
    @required this.id,
    @required this.color,
    Color outlineColor,
    this.size
  }) : this.outlineColor = outlineColor ?? Colors.grey.shade200;

  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: outlineColor)
        ),
        child: Icon(
          IconData(
            codePoint,
            fontFamily: 'MaterialIcons'
          ),
          color: color,
          size: size,
        ),
      ),
    );
  }

}