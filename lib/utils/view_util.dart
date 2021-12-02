import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///view间距
///[height] 竖向，[width]横向
SizedBox viewSpace({double height: 1, double width: 1}) {
  return SizedBox(height: height, width: width);
}

///listView间隔线
borderLine(BuildContext context, {bottom: true, top: false}) {
  BorderSide borderSide = BorderSide(width: 0.5, color: Colors.grey[200]!);
  return Border(
    bottom: bottom ? borderSide : BorderSide.none,
    top: top ? borderSide : BorderSide.none,
  );
}
