import 'package:flutter/material.dart';
import 'package:flutter_project/http/core/f_net_state.dart';

class HomeTabPage extends StatefulWidget {

  final String? name;

  const HomeTabPage({Key? key, this.name}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends FNetState<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.name!),
    );
  }
}
