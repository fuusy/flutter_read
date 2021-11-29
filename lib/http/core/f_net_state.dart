import 'package:flutter/cupertino.dart';

///主要解决页面销毁时，调用setState
abstract class FNetState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    } else {
      print('页面已销毁');
    }
  }
}
