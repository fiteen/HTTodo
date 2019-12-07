import 'package:fish_redux/fish_redux.dart';

class AddTaskState implements Cloneable<AddTaskState> {
  String newTask;
  String taskId;

  @override
  AddTaskState clone() {
    return AddTaskState()
      ..newTask = newTask
      ..taskId = taskId;
  }
}

AddTaskState initState(Map<String, dynamic> args) {
  return AddTaskState()
    ..newTask = ""
    ..taskId = args["taskId"];
}
