import 'package:flutter/material.dart';
import 'package:flutter_project/db/sp_cache.dart';
import 'package:flutter_project/global.dart';
import 'package:flutter_project/navigator/bottom_navigator.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';
import 'package:flutter_project/page/about_page.dart';
import 'package:flutter_project/page/article_page.dart';
import 'package:flutter_project/page/login_page.dart';
import 'package:flutter_project/page/my_collect_page.dart';
import 'package:flutter_project/page/register_page.dart';
import 'package:flutter_project/page/setting_page.dart';
import 'package:flutter_project/page/video_detail_page.dart';
import 'package:flutter_project/page/webview_page.dart';
import 'package:flutter_project/provider/provider_manager.dart';
import 'package:flutter_project/provider/theme_provider.dart';
import 'package:flutter_project/utils/toast_util.dart';
import 'package:provider/provider.dart';

import 'http/core/dio_adapter.dart';
import 'model/video_model.dart';

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

    DioAdapter.initCookJar();
    return FutureBuilder<SpCache?>(
        future: SpCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<SpCache?> snap) {
          var widget = snap.connectionState == ConnectionState.done
              ? Router(
                  routerDelegate: _routeDelegate,
                )
              : Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

          return MultiProvider(
            providers: topProviders,
            child: Consumer<ThemeProvider>(builder: (BuildContext context,
                ThemeProvider themeProvider, Widget? child) {
              return MaterialApp(
                home: widget,
                theme: themeProvider.getTheme(),
                darkTheme: themeProvider.getTheme(isDarkMode: true),
                themeMode: themeProvider.getThemeMode(),
              );
            }),
          );
        });
  }
}

class FRouteDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  FRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //跳转listener
    FRouter.getInstance()!.registerRouteJumpListener(
        RouteIntentListener(onJumpTo: (RouteStatus status, {Map? args}) {
      _routeStatus = status;
      switch (status) {
        case RouteStatus.detail:
          this.videoModel = args!['videoModel'];
          break;
        case RouteStatus.webview:
          this.articleUrl = args!['article_path'];
          this.articleTitle = args['article_title'];
          break;
        case RouteStatus.article:
          this.cid = args!['article_cid'];
          this.articleTitle = args['article_title'];
          break;
      }

      notifyListeners();
    }));
  }

  List<MaterialPage> pages = [];
  VideoModel? videoModel;
  String? articleUrl;
  String? articleTitle;
  int cid = 0;

  RoutePath? path;
  RouteStatus _routeStatus = RouteStatus.home;

  RouteStatus get routeStatus {
    if ((_routeStatus == RouteStatus.collect) &&
        !SpCache.getInstance()!.isLogin()) {
      showToast("请先登录");
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
    switch (routeStatus) {
      case RouteStatus.home:
        pages.clear();
        page = pageWrap(BottomNavigator());
        break;
      case RouteStatus.login:
        page = pageWrap(LoginPage());
        break;
      case RouteStatus.register:
        page = pageWrap(RegisterPage());
        break;
      case RouteStatus.detail:
        page = pageWrap(VideoDetailPage(videoModel!));
        break;
      case RouteStatus.webview:
        page = pageWrap(WebViewPage(url: articleUrl, title: articleTitle));
        break;
      case RouteStatus.article:
        page = pageWrap(ArticlePage(
          cid: cid,
          title: articleTitle,
        ));
        break;
      case RouteStatus.collect:
        page = pageWrap(MyCollectPage());
        break;
      case RouteStatus.about:
        page = pageWrap(AboutPage());
        break;
      case RouteStatus.setting:
        page = pageWrap(SettingPage());
        break;
    }

    tempPages = [...tempPages, page];
    pages = tempPages;

    //进入页面 通知路由变化
    FRouter.getInstance()?.notify(tempPages, pages);

    return WillPopScope(
        child: Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (route, result) {
            if (route.settings is MaterialPage) {
              if ((route.settings as MaterialPage).child is LoginPage) {
                // if (LoginDao.getToken() == null) {
                //   showToast('请先登录');
                //   return false;
                // }
              }
            }

            if (!route.didPop(result)) {
              return false;
            }

            //退出时，通知页面变化
            var tempPages = [...pages];
            pages.removeLast();
            FRouter.getInstance()?.notify(pages, tempPages);
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
