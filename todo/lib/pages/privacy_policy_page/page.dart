import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'view.dart';

class PrivacyPolicyPage extends Page<PrivacyPolicyPageState, Map<String, dynamic>> {
  PrivacyPolicyPage()
      : super(
            initState: initState,
            view: buildView,
            );
}
