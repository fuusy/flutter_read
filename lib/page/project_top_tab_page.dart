import 'package:flutter/material.dart';
import 'package:flutter_project/http/core/f_net_state.dart';

class ProjectTabPage extends StatefulWidget {

  final String? name;

  const ProjectTabPage({Key? key, this.name}) : super(key: key);

  @override
  _ProjectTabPageState createState() => _ProjectTabPageState();
}

class _ProjectTabPageState extends FNetState<ProjectTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.name!),
    );
  }
}
