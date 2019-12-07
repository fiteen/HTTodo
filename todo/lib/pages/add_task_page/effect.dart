import 'package:flutter/material.dart' hide Action;
import 'package:fish_redux/fish_redux.dart';
import 'package:todo/model/todo_model.dart';
import 'action.dart';
import 'state.dart';

Effect<AddTaskState> buildEffect() {
  return combineEffects(<Object, Effect<AddTaskState>>{
    AddTaskAction.onAddTask: _onAddTaskAction,
  });
}

void _onAddTaskAction(Action action, Context<AddTaskState> ctx) {
  action.payload["model"].addTodo(
      Todo(
        action.payload["newTask"],
        parent: action.payload["taskId"],            
      )
    );
    Navigator.pop(ctx.context);
}
