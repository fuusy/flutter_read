import 'package:flutter/material.dart';
import 'package:flutter_project/navigator/bottom_navigator.dart';
import 'package:flutter_project/page/about_page.dart';
import 'package:flutter_project/page/article_page.dart';
import 'package:flutter_project/page/home_page.dart';
import 'package:flutter_project/page/login_page.dart';
import 'package:flutter_project/page/my_collect_page.dart';
import 'package:flutter_project/page/register_page.dart';
import 'package:flutter_project/page/setting_page.dart';
import 'package:flutter_project/page/video_detail_page.dart';
import 'package:flutter_project/page/webview_page.dart';

///路由状态变化listener
///通过堆栈信息发送变化来判断
typedef RouteChangeListener(RouteStatusInfo curInfo, RouteStatusInfo preInfo);

///创建页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

///page在堆栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus status) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == status) {
      return i;
    }
  }

  return -1;
}

///枚举，代表页面
enum RouteStatus {
  login,
  register,
  home,
  detail,
  webview,
  article,
  collect,
  about,
  setting,
  unknown
}

RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegisterPage) {
    return RouteStatus.register;
  } else if (page.child is BottomNavigator) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  } else if (page.child is WebViewPage) {
    return RouteStatus.webview;
  } else if (page.child is ArticlePage) {
    return RouteStatus.article;
  } else if (page.child is MyCollectPage) {
    return RouteStatus.collect;
  } else if (page.child is AboutPage) {
    return RouteStatus.about;
  } else if (page.child is SettingPage) {
    return RouteStatus.setting;
  }
  else {
    return RouteStatus.unknown;
  }
}

class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

///页面跳转
class FRouter extends _RouteIntentListener {
  static FRouter? _instance;
  RouteIntentListener? routeJumpListener;
  List<RouteChangeListener> _listener = [];

  RouteStatusInfo? _cur;
  RouteStatusInfo? _bottomTab;

  static FRouter? getInstance() {
    if (_instance == null) {
      _instance = FRouter();
    }
    return _instance;
  }

  void addRouteListener(RouteChangeListener listener) {
    if (!_listener.contains(listener)) {
      _listener.add(listener);
    }
  }

  void removeRouteListener(RouteChangeListener listener) {
    if (_listener.contains(listener)) {
      _listener.remove(listener);
    }
  }

  void notify(List<MaterialPage> curPages, List<MaterialPage> prePages) {
    if (curPages == prePages) return;

    //取最顶部
    var cur = RouteStatusInfo(getStatus(curPages.last), curPages.last.child);
    _notify(cur);
  }

  //注册跳转listener
  void registerRouteJumpListener(RouteIntentListener listener) {
    this.routeJumpListener = listener;
  }

  ///底部tab切换监听
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  @override
  void onIntentTo(RouteStatus status, {Map? args}) {
    routeJumpListener!.onJumpTo!(status, args: args);
  }

  void _notify(RouteStatusInfo cur) {
    if (cur.page is BottomNavigator && _bottomTab != null) {
      cur = _bottomTab!;
    }
    _listener.forEach((element) {
      element(cur, _cur!);
    });
    _cur = cur;
  }
}

abstract class _RouteIntentListener {
  void onIntentTo(RouteStatus status, {Map args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

class RouteIntentListener {
  final OnJumpTo? onJumpTo;

  RouteIntentListener({this.onJumpTo});
}
