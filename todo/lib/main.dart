import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/redux/app_route.dart';
import 'package:todo/model/task_list_model.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/model/hero_id_model.dart';
import 'package:todo/model/data/choice_card.dart';
import 'package:todo/utils/datetime_utils.dart';
import 'package:todo/utils/color_utils.dart';
import 'package:todo/widgets/add_page_card/widget.dart';
import 'package:todo/widgets/gradient_background/widget.dart';
import 'package:todo/pages/page_path.dart';
import 'package:todo/widgets/task_card/widget.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var app = MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400),
            title: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hint'),
          )),
      home: MyHomePage(title: ''),
      onGenerateRoute: (RouteSettings item) {
        return MaterialPageRoute<Object>(builder: (BuildContext context) {
          return AppRoute.global.buildPage(item.name, item.arguments);
        });
      },
    );

    return ScopedModel<TodoListModel>(
      model: TodoListModel(),
      child: app,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  HeroId _generateHeroId(Task task) {
    return HeroId(
        nameId: 'name_id_${task.id}',
        codePointId: 'code_point_id_${task.id}',
        progressId: 'progress_id_${task.id}',
        remainingTaskId: 'remaining_task_id_${task.id}');
  }

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TodoListModel>(
        builder: (BuildContext context, Widget child, TodoListModel model) {
      bool _isLoading = model.isLoading;
      if (!_isLoading) {
        _controller.forward();
      }
      var _tasks = model.tasks;
      var _todos = model.todos;
      var backgroundColor = _tasks.isEmpty || _tasks.length == _currentPageIndex
          ? Colors.blueGrey
          : ColorUtils.getColorFrom(_tasks[_currentPageIndex].color);

      return GradientBackground(
        color: backgroundColor,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(widget.title),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              PopupMenuButton<Choice>(
                onSelected: (choice) {
                  Navigator.of(context).pushNamed(PagePath.privacyPolicyPage);
                },
                itemBuilder: (BuildContext context) {
                  return choices.map((Choice choice) {
                    return PopupMenuItem<Choice>(
                      value: choice,
                      child: Text(choice.title),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: _isLoading
              ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.0,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
              : FadeTransition(
                  opacity: _animation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 0.0, left: 56.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                child: Text(
                              '${DateTimeUtils.currentDay}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(color: Colors.white),
                            )),
                            Text(
                              '${DateTimeUtils.currentDate} ${DateTimeUtils.currentMonth}',
                              style: Theme.of(context).textTheme.title.copyWith(
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                            Container(height: 16.0),
                            Text(
                              'You have ${_todos.where((todo) => todo.isCompleted == 0).length} tasks to complete',
                              style: Theme.of(context).textTheme.body1.copyWith(
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                            Container(height: 16.0),
                          ],
                        ),
                      ),
                      Expanded(
                        key: _backdropKey,
                        flex: 1,
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification is ScrollEndNotification) {
                              var currentPage =
                                  _pageController.page.round().toInt();
                              if (_currentPageIndex != currentPage) {
                                setState(() => _currentPageIndex = currentPage);
                              }
                            }
                            return true;
                          },
                          child: PageView.builder(
                            controller: _pageController,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == _tasks.length) {
                                return AddPageCard(color: Colors.blueGrey);
                              } else {
                                return TaskCard(
                                    backdropKey: _backdropKey,
                                    task: _tasks[index],
                                    color: ColorUtils.getColorFrom(
                                        _tasks[index].color),
                                    heroId:
                                        widget._generateHeroId(_tasks[index]),
                                    totalTodos:
                                        model.getTotalTodosFrom(_tasks[index]),
                                    taskProgress:
                                        model.getTaskCompletionPercent(
                                            _tasks[index]));
                              }
                            },
                            itemCount: _tasks.length + 1,
                          ),
                        ),
                      ),
                      Container(height: 32.0)
                    ],
                  ),
                ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}