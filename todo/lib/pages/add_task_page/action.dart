import 'package:flutter/material.dart' hide Action;
import 'package:fish_redux/fish_redux.dart';
import 'package:todo/model/task_list_model.dart';

enum AddTaskAction { onAddTask }

class AddTaskActionCreator {
  static Action addTaskAction(Color color, TodoListModel model, String newTask, String taskId) {
    return Action(AddTaskAction.onAddTask, payload: {
      "color": color,
      "model": model,
      "newTask": newTask,
      "taskId": taskId
    });
  }
}
