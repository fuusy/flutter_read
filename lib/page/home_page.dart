import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/http/core/f_net_state.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends FNetState<HomePage>
    with AutomaticKeepAliveClientMixin {
  var listener;

  @override
  void initState() {
    super.initState();
    FNavigator.getInstance()?.addRouteListener(
        this.listener = (curInfo, preInfo) => {print('home ${curInfo.page}')});
  }

  @override
  void dispose() {
    super.dispose();
    FNavigator.getInstance()?.removeRouteListener(this.listener);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
