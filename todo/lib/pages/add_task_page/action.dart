import 'package:flutter/material.dart' hide Action;
import 'package:fish_redux/fish_redux.dart';
import 'package:todo/model/task_list_model.dart';

enum AddTaskAction { action }

class AddTaskActionCreator {
  static Action onAction(Color color, TodoListModel model, String newTask, String taskId) {
    return Action(AddTaskAction.action, payload: {
      "color": color,
      "model": model,
      "newTask": newTask,
      "taskId": taskId
    });
  }
}
