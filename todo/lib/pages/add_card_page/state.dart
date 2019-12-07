import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:todo/utils/color_utils.dart';

class AddCardState implements Cloneable<AddCardState> {
  String category;
  Color taskColor;
  IconData taskIcon;
  @override
  AddCardState clone() {
    return AddCardState()
      ..category
      ..taskColor
      ..taskIcon;
  }
}

AddCardState initState(Map<String, dynamic> args) {
  return AddCardState()
    ..category = ""
    ..taskColor = ColorUtils.defaultColors[0]
    ..taskIcon = Icons.work;
}
