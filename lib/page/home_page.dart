import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/http/model/video_model.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var listener;
  @override
  void initState() {
    super.initState();
    FNavigator.getInstance()?.addRouteListener(this.listener = (curInfo, preInfo) => {
      print('home ${curInfo.page}')
    });
  }

  @override
  void dispose() {
    super.dispose();
    FNavigator.getInstance()?.removeRouteListener(this.listener);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text('首页'),
            MaterialButton(
              onPressed: () => {
                FNavigator.getInstance()!.onJumpTo(RouteStatus.detail,
                    args: {'videoModel': VideoModel(1)})
              },
              child: Text('跳转到详情'),
            )
          ],
        ),
      ),
    );
  }
}
