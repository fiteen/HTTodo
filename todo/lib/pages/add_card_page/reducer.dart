import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AddCardState> buildReducer() {
  return asReducer(
    <Object, Reducer<AddCardState>>{
      AddCardAction.changeState: _changeStateAction,
    },
  );
}

AddCardState _changeStateAction(AddCardState state, Action action) {
  AddCardState state = action.payload;
  final AddCardState newState = state.clone()
    ..category = state.category
    ..taskColor = state.taskColor
    ..taskIcon = state.taskIcon;
  return newState;
}
