import 'dart:convert';

import 'package:flutter_project/model/mine/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 缓存基类
class SpCache {
  static User user = User();
  SharedPreferences? sp;

  SpCache._() {
    init();
  }

  static SpCache? _instance;

  SpCache._pre(SharedPreferences preferences) {
    this.sp = preferences;
  }

  static Future<SpCache?> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = SpCache._pre(prefs);
    }

    return _instance;
  }

  static SpCache? getInstance() {
    if (_instance == null) {
      _instance = SpCache._();
    }
    return _instance;
  }

  void init() async {
    if (sp == null) {
      sp = await SharedPreferences.getInstance();
    }
  }

  setString(String key, String value) {
    sp?.setString(key, value);
  }

  Object? get<T>(String key) {
    return sp?.get(key) ?? null;
  }

  ///保存一个对象
  void _putObject(String key, Object value) {
    sp!.setString(key, json.encode(value));
  }

  ///保存登录后的用户信息
  ///已登录
  void saveUser(User user) {
    _putObject("key_user", user);
    sp!.setBool("key_is_login", true);
  }

  ///判断是否已经登录
  bool isLogin() {
    return sp!.getBool("key_is_login") ?? false;
  }

  ///获取User数据
  User getUser() {
    Map? userMap = getObject("key_user");
    if(userMap!=null){
      var user = User.fromJsonMap(userMap);
      return user;
    }
    return User();
  }

  Map? getObject(String key) {
    String? _data = sp?.getString(key);
    return (_data == null || _data.isEmpty) ? null : json.decode(_data);
  }
}
