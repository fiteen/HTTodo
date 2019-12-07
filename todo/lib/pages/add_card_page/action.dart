import 'package:fish_redux/fish_redux.dart';
import 'package:todo/model/task_list_model.dart';

import 'state.dart';

enum AddCardAction { changeState, onAddCategory }

class AddCardActionCreator {
  static Action changeState(AddCardState state) {
    return Action(AddCardAction.changeState, payload: state);
  }

  static Action onAddCategory(AddCardState state, TodoListModel model) {
    return Action(AddCardAction.onAddCategory, payload: {
      "category": state.category,
      "taskColor": state.taskColor,
      "taskIconCodePoint": state.taskIcon.codePoint,
      "model": model,
    });
  }
}
