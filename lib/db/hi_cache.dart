import 'package:shared_preferences/shared_preferences.dart';

/// 缓存基类
class HiCache {
  SharedPreferences? pres;

  HiCache._() {
    init();
  }

  static HiCache? _instance;

  HiCache._pre(SharedPreferences preferences) {
    this.pres = preferences;
  }

  static Future<HiCache?> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }

    return _instance;
  }

  static HiCache? getInstance() {
    if (_instance == null) {
      _instance = HiCache._();
    }
    return _instance;
  }

  void init() async {
    if (pres == null) {
      pres = await SharedPreferences.getInstance();
    }
  }

  setString(String key, String value) {
    pres?.setString(key, value);
  }

  Object? get<T>(String key) {
    return pres?.get(key);
  }
}
