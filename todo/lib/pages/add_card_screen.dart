import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/utils/color_utils.dart';
import 'package:todo/model/task_list_model.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/widgets/color_picker_builder/widget.dart';
import 'package:todo/widgets/icon_picker_builder/widget.dart';

class AddCardScreen extends StatefulWidget {
  AddCardScreen();

  @override
  State<StatefulWidget> createState() {
    return _AddCardScreenState();
  }
}

class _AddCardScreenState extends State<AddCardScreen> {
  String category;
  Color taskColor;
  IconData taskIcon;

  @override
  void initState() {
    super.initState();
    setState(() {
      category = '';
      taskColor = ColorUtils.defaultColors[0];
      taskIcon = Icons.work;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TodoListModel>(
      builder: (BuildContext context, Widget child, TodoListModel model) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'New Category',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black26),
            brightness: Brightness.light,
          ),
          body: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Category will help you group related task!',
                  style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                ),
                Container(height: 16.0),
                TextField(
                  autofocus: true,
                  cursorColor: taskColor,
                  onChanged: (text) {
                    setState(() => category = text);
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Category Name...',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      )),
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 36.0),
                ),
                Container(height: 26.0),
                Row(
                  children: [
                    ColorPickerBuilder(
                      color: taskColor,
                      onColorChanged: (newColor) =>
                          setState(() => taskColor = newColor),
                    ),
                    Container(width: 22.0),
                    IconPickerBuilder(
                      iconData: taskIcon,
                      highlightColor: taskColor,
                      onIconChanged: (newIcon) =>
                          setState(() => taskIcon = newIcon),
                    ),
                  ],
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
                icon: Icon(Icons.save),
                label: Text('Create New Card'),
                backgroundColor: taskColor,
                onPressed: () {
                  if (category.isEmpty) {
                    final snackBar = SnackBar(
                      backgroundColor: taskColor,
                      content: Text(
                          'Ummm...It seems that you are trying to add invisible category which is not allowed in this realm.'),
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  } else {
                    model.addTask(Task(
                      category,
                      codePoint: taskIcon.codePoint,
                      color: taskColor.value
                    ));
                    Navigator.pop(context);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}