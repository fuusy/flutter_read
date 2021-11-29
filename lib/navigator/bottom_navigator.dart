import 'package:flutter/material.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';
import 'package:flutter_project/page/favorite_page.dart';
import 'package:flutter_project/page/home_page.dart';
import 'package:flutter_project/page/mine_page.dart';
import 'package:flutter_project/page/project_page.dart';
import 'package:flutter_project/utils/color.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _curIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);
  List<Widget> _pages = [];

  static int initialPage = 0;
  bool _hasBuild = false;

  @override
  Widget build(BuildContext context) {
    _pages = [
      HomePage(),
      ProjectPage(),
      FavoritePage(),
      MinePage(),
    ];

    if (!_hasBuild) {
      FNavigator.getInstance()
          ?.onBottomTabChange(initialPage, _pages[initialPage]);
      _hasBuild = true;
    }
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          _onJumpTo(index, pageChange: true);
        },
        physics: NeverScrollableScrollPhysics(), //viewpage禁止左右滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _curIndex,
        onTap: (index) => _onJumpTo(index),
        type: BottomNavigationBarType.fixed,
        //显示bottom bar底部文字
        selectedItemColor: primary[50],
        items: [
          _bottomItem('首页', Icons.home, 0),
          _bottomItem('项目', Icons.local_fire_department, 1),
          _bottomItem('收藏', Icons.favorite, 2),
          _bottomItem('我的', Icons.person, 3),
        ],
      ),
    );
  }

  _bottomItem(String s, IconData icon, int i) {
    return BottomNavigationBarItem(
        icon: Icon(icon, color: Colors.grey),
        activeIcon: Icon(icon, color: primary[50]),
        label: s);
  }

  void _onJumpTo(int value, {pageChange = false}) {
    if (!pageChange) {
      _pageController.jumpToPage(value);
    } else {
      FNavigator.getInstance()?.onBottomTabChange(value, _pages[value]);
    }
    setState(() {
      _curIndex = value;
    });
  }
}
