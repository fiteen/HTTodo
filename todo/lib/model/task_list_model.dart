import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/db/db_provider.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/model/todo_model.dart';

class TodoListModel extends Model {
  bool _isLoading = false;
  List<Task> _tasks = [];
  List<Todo> _todos = [];
  Map<String, int> _taskCompletionPercentage = Map();

  // var _db = DBProvider.db;
  bool get isLoading => _isLoading;
  List<Task> get tasks => _tasks.toList();
  List<Todo> get todos => _todos.toList();
  int getTaskCompletionPercent(Task task) => _taskCompletionPercentage[task.id];
  int getTotalTodosFrom(Task task) => todos.where((t) => t.parent == task.id).length;

  var _db = DBProvider.db;

  static TodoListModel of(BuildContext context) =>
      ScopedModel.of<TodoListModel>(context);

  @override
  void addListener(listener) {
    super.addListener(listener);
    _isLoading = true;
    loadTodos();
    notifyListeners();
  }

  @override
  void removeListener(listener) {
    super.removeListener(listener);
    print("remove listener called");
  }

  void loadTodos() async {
    var isNew = !await DBProvider.db.dbExits();
    if (isNew) {
      // init todo data
    }
    _tasks = await _db.getAllTask();
    _todos = await _db.getAllTodo();
    _tasks.forEach((t) => _calcTaskCompletionPercent(t.id));
    _isLoading = false;
    await Future.delayed(Duration(milliseconds: 300));
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    _calcTaskCompletionPercent(task.id);
    _db.insertTask(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _db.removeTask(task).then((_) {
      _tasks.removeWhere((t) => t.id == task.id);
      _todos.removeWhere((t) => t.parent == task.id);
      notifyListeners();
    });
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    _calcTaskCompletionPercent(todo.parent);
    _db.insertTodo(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);
    _calcTaskCompletionPercent(todo.parent);
    _db.removeTodo(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    var oldTodo = _todos.firstWhere((t) => t.id == todo.id);
    var replaceIndex = _todos.indexOf(oldTodo);
    _todos.replaceRange(replaceIndex, replaceIndex + 1, [todo]);
    _calcTaskCompletionPercent(todo.parent);
    _db.updateTodo(todo);
    notifyListeners();
  }

  void _calcTaskCompletionPercent(String taskId) {
    var todos = this.todos.where((t) => t.parent == taskId);
    var totalTodos = todos.length;

    if (totalTodos == 0) {
      _taskCompletionPercentage[taskId] = 0;
    } else {
      var totalCompletedTodos = todos.where((t) => t.isCompleted == 1).length;
      _taskCompletionPercentage[taskId] = (totalCompletedTodos / totalTodos * 100).toInt();
    }
  }

}