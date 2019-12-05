import 'package:flutter/material.dart';
import 'package:todo/model/hero_id_model.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/pages/detail_screen.dart';
import 'package:todo/route/scale_route.dart';
import 'package:todo/utils/color_utils.dart';
import 'package:todo/widgets/task_progress_indicator/widget.dart';
import 'package:todo/widgets/todo_badge/widget.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Color color;
  final HeroId heroId;
  final int totalTodos;
  final int taskProgress;
  final GlobalKey backdropKey;

  TaskCard({
    @required this.task,
    @required this.color,
    @required this.heroId,
    @required this.totalTodos,
    @required this.taskProgress,
    @required this.backdropKey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final RenderBox renderBox =
            backdropKey.currentContext.findRenderObject();
        var backDropHeight = renderBox.size.height;
        var bottomOffset = 60.0;
        var horizontalOffset = 52.0;

        var rect = RelativeRect.fromLTRB(horizontalOffset,
            MediaQuery.of(context).size.height - backDropHeight, horizontalOffset, bottomOffset);
        Navigator.push(
            context,
            ScaleRoute(
              rect: rect,
              widget: DetailScreen(
                taskId: task.id,
                heroId: heroId,
              ),
            ));
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        color: Colors.white,
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TodoBadge(
                id: heroId.codePointId,
                codePoint: task.codePoint,
                color: ColorUtils.getColorFrom(task.color),
              ),
              Spacer(flex: 8),
              Container(
                margin: EdgeInsets.only(bottom: 4.0),
                child: Hero(
                  tag: heroId.remainingTaskId,
                  child: Text(
                    "$totalTodos Task",
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Colors.grey[500]),
                  ),
                ),
              ),
              Hero(
                tag: heroId.nameId,
                child: Text(
                  task.name,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.black54),
                ),
              ),
              Spacer(),
              Hero(
                tag: heroId.progressId,
                child: TaskProgressIndicator(
                  color: color,
                  progress: taskProgress,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}