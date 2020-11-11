import 'package:flutter_common_template/actions/actions.dart';
import 'package:flutter_common_template/models/models.dart';

class ValidateAction extends BaseAction {
  @override
  AppState reduce() => state.copy();
}
