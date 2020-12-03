class LogUtils {
  static const String _TAG_DEFAULT = "#Flutter#";

  // 是否是debug模式, 如果为true, v 不输出
  static bool debug = false;

  static void init({bool isDebug = false, String tag = _TAG_DEFAULT}) {
    debug = isDebug;
    tag = tag;
  }

  static void e(Object object, {String? tag}) {
    _printLog(tag, '  e  ', object);
  }

  static void v(Object object, {String? tag}) {
    if (debug) {
      _printLog(tag, '  v  ', object);
    }
  }

  static void _printLog(String? tag, String stag, Object object) {
    StringBuffer buff = StringBuffer();
    buff.write((tag == null || tag.isEmpty) ? _TAG_DEFAULT : tag);
    buff.write(stag);
    buff.write(object);
    print(buff.toString());
  }
}
