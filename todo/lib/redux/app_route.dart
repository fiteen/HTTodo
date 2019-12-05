import 'package:fish_redux/fish_redux.dart';
import 'package:todo/pages/privacy_policy_page/page.dart';
import 'package:todo/pages/page_path.dart';

class AppRoute {
  static AbstractRoutes _global;
  static AbstractRoutes get global {
    if (_global == null) {
      _global = PageRoutes(
        pages: <String, Page<Object, dynamic>> {
          PagePath.privacyPolicyPage: PrivacyPolicyPage()
        },
      );
    }
    return _global;
  }

}