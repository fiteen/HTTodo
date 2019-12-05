import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/widgets/todo_badge/widget.dart';
import 'package:todo/widgets/task_progress_indicator/widget.dart';
import 'package:todo/widgets/delete_alert_dialog/widget.dart';
import 'package:todo/model/task_list_model.dart';
import 'package:todo/model/hero_id_model.dart';
import 'package:todo/pages/add_todo_screen.dart';
import 'package:todo/utils/color_utils.dart';

class DetailScreen extends StatefulWidget {
  final String taskId;
  final HeroId heroId;

  DetailScreen({
    @required this.taskId,
    @required this.heroId,
  });

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(begin: Offset(0, 1.0), end: Offset(0.0, 0.0))
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return ScopedModelDescendant<TodoListModel>(
      builder: (BuildContext context, Widget child, TodoListModel model) {
        var _task;

        try {
          _task = model.tasks.firstWhere((t) => t.id == widget.taskId);
        } catch (e) {
          return Container(color: Colors.white);
        }

        var _todos =
            model.todos.where((t) => t.parent == widget.taskId).toList();
        var _hero = widget.heroId;
        var _color = ColorUtils.getColorFrom(_task.color);
        return Theme(
            data: ThemeData(primarySwatch: _color),
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0.0,
                iconTheme: IconThemeData(color: Colors.black26),
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                actions: <Widget>[
                  DeleteAlertDialog(
                    color: _color,
                    onActionPressed: () => model.removeTask(_task),
                  )
                ],
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                child: Column(children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 36.0, vertical: 0.0),
                    height: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TodoBadge(
                          id: _hero.codePointId,
                          color: _color,
                          codePoint: _task.codePoint,
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 4.0),
                            child: Hero(
                              tag: _hero.remainingTaskId,
                              child: Text(
                                "${model.getTotalTodosFrom(_task)} Task",
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(color: Colors.grey[500]),
                              ),
                            )),
                        Hero(
                          tag: _hero.nameId,
                          child: Text(_task.name,
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: Colors.black54)),
                        ),
                        Spacer(),
                        Hero(
                          tag: _hero.progressId,
                          child: TaskProgressIndicator(
                            color: _color,
                            progress: model.getTaskCompletionPercent(_task),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          var todo = _todos[index];
                          return Container(
                            padding: EdgeInsets.only(left: 22.0, right: 22.0),
                            child: ListTile(
                              onTap: () => model.updateTodo(todo.copy(
                                  isCompleted: todo.isCompleted == 1 ? 0 : 1)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 0.0),
                              leading: Checkbox(
                                  onChanged: (value) => model.updateTodo(
                                      todo.copy(
                                          isCompleted:
                                              todo.isCompleted == 1 ? 0 : 1)),
                                  value: todo.isCompleted == 1 ? true : false),
                              title: Text(
                                todo.name,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: todo.isCompleted == 1
                                        ? _color
                                        : Colors.black54,
                                    decoration: todo.isCompleted == 1
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete_outline),
                                onPressed: () => model.removeTodo(todo),
                              ),
                            ),
                          );
                        },
                        itemCount: _todos.length,
                      ),
                    ),
                  )
                ]),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: _color,
                foregroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddTodoScreen(taskId: widget.taskId),
                      ));
                },
              ),
            ));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
