import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/provider/theme_provider.dart';
import 'package:flutter_project/utils/color.dart';
import 'package:provider/provider.dart';

class NavigationBar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? childWidget;

  const NavigationBar(
      {Key? key,
      this.statusStyle = StatusStyle.DARK_STYLE,
      this.color = Colors.white,
      this.height = 45,
      this.childWidget})
      : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  var _color;
  var _statusStyle;

  @override
  Widget build(BuildContext context) {
    //沉浸式状态栏样式
    var brightness;

    var themeProvider = context.watch<ThemeProvider>();
    if (themeProvider.isDark()) {
      _color = BaColors.dark_bg;
      _statusStyle = StatusStyle.LIGHT_STYLE;
    }else{
      _color = widget.color;
      _statusStyle = StatusStyle.DARK_STYLE;
    }

    if (Platform.isIOS) {
      brightness = _statusStyle == StatusStyle.LIGHT_STYLE
          ? Brightness.dark
          : Brightness.light;
    } else {
      brightness = _statusStyle == StatusStyle.LIGHT_STYLE
          ? Brightness.light
          : Brightness.dark;
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
    ));

    var top = MediaQuery.of(context).padding.top; //刘海屏 刘海的高度
    print('top : $top');
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      child: widget.childWidget,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: _color),
    );
  }
}

enum StatusStyle { LIGHT_STYLE, DARK_STYLE }
