import 'package:fish_redux/fish_redux.dart';
import 'package:todo/model/hero_id_model.dart';

class AddTaskState implements Cloneable<AddTaskState> {
  String newTask;
  String taskId;
  HeroId heroIds;

  @override
  AddTaskState clone() {
    return AddTaskState()
      ..newTask = newTask
      ..taskId = taskId
      ..heroIds = heroIds;
  }
}

AddTaskState initState(Map<String, dynamic> args) {
  return AddTaskState()
    ..newTask = ""
    ..taskId = args["taskId"]
    ..heroIds = args["heroIds"];
}
