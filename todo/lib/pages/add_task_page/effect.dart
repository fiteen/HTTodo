import 'package:flutter/material.dart' hide Action;
import 'package:fish_redux/fish_redux.dart';
import 'package:todo/model/todo_model.dart';
import 'action.dart';
import 'state.dart';

Effect<AddTaskState> buildEffect() {
  return combineEffects(<Object, Effect<AddTaskState>>{
    AddTaskAction.action: _onAction,
  });
}

void _onAction(Action action, Context<AddTaskState> ctx) {
  String newTask = action.payload["newTask"];
  if (newTask.isEmpty) {
    final snackBar = SnackBar(
      backgroundColor: action.payload["color"],
      content: Text(
          'Ummm...It seems that you are trying to add invisible task which is not allowed in this realm.'),
    );
    Scaffold.of(ctx.context).showSnackBar(snackBar);
  } else {
    action.payload["model"].addTodo(
      Todo(
        newTask,
        parent: action.payload["taskId"],            
      )
    );
    Navigator.pop(ctx.context);
  }
}
