import 'package:recase/recase.dart';

class JsonUtils {
  static Map<String, dynamic> toCamelCaseFromJson(Map<String, dynamic> json) {
    return json.map((key, value) => MapEntry(key.camelCase, value));
  }

  static Map<String, dynamic> toSnakeLowerCaseJson(Map<String, dynamic> json) {
    return json
        .map((key, value) => MapEntry(key.constantCase.toLowerCase(), value));
  }
}
