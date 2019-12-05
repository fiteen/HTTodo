import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskProgressIndicator extends StatelessWidget {
  final Color color;
  final progress;
  final _height = 3.0;

  TaskProgressIndicator({
    @required this.color,
    @required this.progress
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                children: <Widget>[
                  Container(
                    height: _height,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: (progress / 100) * constraints.maxWidth,
                    height: _height,
                    color: color,
                  ),
                ],
              );
            }
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 8.0),
          child: Text(
            "$progress%",
            style: Theme.of(context).textTheme.caption,
          ),
        )
      ],
    );
  }
}