import 'package:fish_redux/fish_redux.dart';
import 'package:todo/pages/privacy_policy_page/page.dart';
import 'package:todo/pages/add_card_page/page.dart';
import 'package:todo/pages/add_task_page/page.dart';
import 'package:todo/pages/page_path.dart';

class AppRoute {
  static AbstractRoutes _global;
  static AbstractRoutes get global {
    if (_global == null) {
      _global = PageRoutes(
        pages: <String, Page<Object, dynamic>> {
          PagePath.privacyPolicyPage: PrivacyPolicyPage(),
          PagePath.addCardPage: AddCardPage(),
          PagePath.addTaskPage: AddTaskPage()
        },
      );
    }
    return _global;
  }
}