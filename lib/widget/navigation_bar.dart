import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///沉浸式状态栏
class NavigationBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    //沉浸式状态栏样式
    var brightness;
    if (Platform.isIOS) {
      brightness = statusStyle == StatusStyle.LIGHT_STYLE
          ? Brightness.dark
          : Brightness.light;
    } else {
      brightness = statusStyle == StatusStyle.LIGHT_STYLE
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
      height: top + height,
      child: childWidget,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: color),
    );
  }
}

enum StatusStyle { LIGHT_STYLE, DARK_STYLE }
