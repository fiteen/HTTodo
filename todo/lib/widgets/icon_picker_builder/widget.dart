import 'package:flutter/material.dart';
import 'package:todo/widgets/icon_picker/widget.dart';
import 'package:todo/widgets/todo_badge/widget.dart';

class IconPickerBuilder extends StatelessWidget {
  final IconData iconData;
  final ValueChanged<IconData> onIconChanged;
  final Color highlightColor;

  IconPickerBuilder(
      {@required this.iconData,
      @required this.onIconChanged,
      Color highlightColor})
      : this.highlightColor = highlightColor;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: 40.0,
        width: 40.0,
        child: Material(
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select an icon'),
                      content: SingleChildScrollView(
                        child: IconPicker(
                            currentIconData: iconData,
                            onIconChanged: onIconChanged,
                            highlightColor: highlightColor),
                      ),
                    );
                  });
            },
            child: TodoBadge(
              id: 'id',
              codePoint: iconData.codePoint,
              color: highlightColor,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
