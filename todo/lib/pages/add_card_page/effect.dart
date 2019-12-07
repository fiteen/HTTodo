import 'package:flutter/material.dart' hide Action;
import 'package:fish_redux/fish_redux.dart';
import 'package:todo/model/task_model.dart';
import 'action.dart';
import 'state.dart';

Effect<AddCardState> buildEffect() {
  return combineEffects(<Object, Effect<AddCardState>>{
    AddCardAction.onAddCategory: _onAddCategoryAction,
  });
}

void _onAddCategoryAction(Action action, Context<AddCardState> ctx) {
  action.payload["model"].addTask(Task(
    action.payload["category"],
    codePoint: action.payload["taskIconCodePoint"],
    color: action.payload["taskColor"].value
  ));
  Navigator.pop(ctx.context);
}