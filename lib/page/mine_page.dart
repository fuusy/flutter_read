import 'package:flutter/material.dart';
import 'package:flutter_project/http/core/f_net_state.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends FNetState<MinePage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  bool get wantKeepAlive => true;
}
