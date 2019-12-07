import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/model/task_list_model.dart';
import 'package:todo/utils/color_utils.dart';
import 'package:todo/widgets/todo_badge/widget.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(AddTaskState state, Dispatch dispatch, ViewService viewService) {
  return ScopedModelDescendant<TodoListModel>(
    builder: (BuildContext context, Widget child, TodoListModel model) {
      if (model.tasks.isEmpty) {
        return Container(
          color: Colors.white,
        );
      }
      var _task = model.tasks.firstWhere((t) => t.id == state.taskId);
      var _color = ColorUtils.getColorFrom(_task.color);
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'New Task',
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
                'What task are you planning to perfrom?',
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0),
              ),
              Container(height: 16.0),
              TextField(
                autofocus: true,
                cursorColor: _color,
                onChanged: (text) {
                  state.newTask = text;
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Your Task...',
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
                  TodoBadge(
                    id: 'id',
                    codePoint: _task.codePoint,
                    color: _color,
                    size: 24,
                  ),
                  Container(width: 22.0),
                  Text(_task.name,
                  style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w600
                  ))
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
              label: Text('Create Task'),
              backgroundColor: _color,
              onPressed: () {
                if (state.newTask.isEmpty) {
                  final snackBar = SnackBar(
                    backgroundColor: _color,
                    content: Text(
                        'Ummm...It seems that you are trying to add invisible task which is not allowed in this realm.'),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                } else {
                  dispatch(AddTaskActionCreator.addTaskAction(_color, model, state.newTask, state.taskId));
                }
              },
            );
          },
        ),
      );
    },
  );
}
