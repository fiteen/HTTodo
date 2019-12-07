import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/model/task_list_model.dart';
import 'package:todo/widgets/color_picker_builder/widget.dart';
import 'package:todo/widgets/icon_picker_builder/widget.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(AddCardState state, Dispatch dispatch, ViewService viewService) {
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
                  cursorColor: state.taskColor,
                  onChanged: (text) {
                    state.category = text;
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
                      color: state.taskColor,
                      onColorChanged: (newColor) {
                        state.taskColor = newColor;
                        dispatch(AddCardActionCreator.changeState(state));
                      }
                    ),
                    Container(width: 22.0),
                    IconPickerBuilder(
                      iconData: state.taskIcon,
                      highlightColor: state.taskColor,
                      onIconChanged: (newIcon) {
                        state.taskIcon = newIcon;
                        dispatch(AddCardActionCreator.changeState(state));
                      }
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
                backgroundColor: state.taskColor,
                onPressed: () {
                  if (state.category.isEmpty) {
                    final snackBar = SnackBar(
                      backgroundColor: state.taskColor,
                      content: Text(
                          'Ummm...It seems that you are trying to add invisible category which is not allowed in this realm.'),
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  } else {
                    dispatch(AddCardActionCreator.onAddCategory(state, model));
                  }
                },
              );
            },
          ),
        );
      },
    );
}
