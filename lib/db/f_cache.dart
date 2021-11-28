import 'package:shared_preferences/shared_preferences.dart';

/// 缓存基类
class FCache {
  SharedPreferences? pres;

  FCache._() {
    init();
  }

  static FCache? _instance;

  FCache._pre(SharedPreferences preferences) {
    this.pres = preferences;
  }

  static Future<FCache?> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = FCache._pre(prefs);
    }

    return _instance;
  }

  static FCache? getInstance() {
    if (_instance == null) {
      _instance = FCache._();
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
