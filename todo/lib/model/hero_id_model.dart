import 'package:meta/meta.dart';

class HeroId {
  final String nameId;
  final String codePointId;
  final String progressId;
  final String remainingTaskId;

  HeroId({
    @required this.nameId,
    @required this.codePointId,
    @required this.progressId,
    @required this.remainingTaskId
  });
}