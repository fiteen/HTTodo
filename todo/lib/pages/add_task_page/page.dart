import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class AddTaskPage extends Page<AddTaskState, Map<String, dynamic>> {
  AddTaskPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            view: buildView,
            dependencies: Dependencies<AddTaskState>(
                adapter: null,
                slots: <String, Dependent<AddTaskState>>{
                }),
            middleware: <Middleware<AddTaskState>>[
            ],);

}
