import 'package:flutter/material.dart';
import 'package:flutter_project/db/f_cache.dart';
import 'package:flutter_project/http/core/f_net.dart';
import 'package:flutter_project/http/dao/login_dao.dart';
import 'package:flutter_project/http/model/video_model.dart';
import 'package:flutter_project/http/test/test_request.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';
import 'package:flutter_project/page/home_page.dart';
import 'package:flutter_project/page/login_page.dart';
import 'package:flutter_project/page/register_page.dart';
import 'package:flutter_project/page/video_detail_page.dart';
import 'package:flutter_project/utils/color.dart';
import 'package:flutter_project/utils/toast_util.dart';

void main() {
  runApp(FApp());
}

class FApp extends StatefulWidget {
  const FApp({Key? key}) : super(key: key);

  @override
  _FAppState createState() => _FAppState();
}

class _FAppState extends State<FApp> {
  FRouteDelegate _routeDelegate = FRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FCache?>(
        future: FCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<FCache?> snap) {
          var widget = snap.connectionState == ConnectionState.done
              ? Router(
            routerDelegate: _routeDelegate,
          )
              : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );

          return MaterialApp(
            home: widget,
            theme: ThemeData(primarySwatch: white),
          );
        });
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FCache.preInit();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: white,
      ),
      home: LoginPage(),
    );
  }
}

class FRouteDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  FRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //跳转listener
    FNavigator.getInstance()!.registerRouteJumpListener(
        RouteJumpListener(onJumpTo: (RouteStatus status, {Map? args}) {
          _routeStatus = status;
          if (status == RouteStatus.detail) {
            this.videoModel = args!['videoModel'];
          }
          notifyListeners();
        }));
  }

  List<MaterialPage> pages = [];
  VideoModel? videoModel;

  RoutePath? path;
  RouteStatus _routeStatus = RouteStatus.home;

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.register && LoginDao.getToken() == null) {
      //不是注册页面且没登录，即跳到登录界面
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      tempPages = tempPages.sublist(0, index);
    }

    //根据状态，创建各个page
    var page;
    if (routeStatus == RouteStatus.home) {
      pages.clear();
      page = pageWrap(HomePage());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel!));
    } else if (routeStatus == RouteStatus.register) {
      page = pageWrap(RegisterPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }

    tempPages = [...tempPages, page];
    pages = tempPages;

    //进入页面 通知路由变化
    FNavigator.getInstance()?.notify(tempPages, pages);

    return WillPopScope(
        child: Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (route, result) {
            if (route.settings is MaterialPage) {
              if ((route.settings as MaterialPage).child is LoginPage) {
                if (LoginDao.getToken() == null) {
                  showToast('请先登录');
                  return false;
                }
              }
            }

            if (!route.didPop(result)) {
              return false;
            }

            //退出时，通知页面变化
            var tempPages = [...pages];
            pages.removeLast();
            FNavigator.getInstance()?.notify(pages, tempPages);
            return true;
          },
        ),
        onWillPop: () async => !await navigatorKey.currentState!.maybePop());
  }

  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {}
}

pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

///页面路径
class RoutePath {
  final String? location;

  RoutePath.home() : location = "/";

  RoutePath.detail() : location = "/detail";
}
