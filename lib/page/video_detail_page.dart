import 'package:flutter/material.dart';
import 'package:flutter_project/model/video_model.dart';

class VideoDetailPage extends StatefulWidget {

  final VideoModel videoModel;

  const VideoDetailPage(this.videoModel);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text('视频详情 ${widget.videoModel.videoId}'),
            MaterialButton(
              onPressed: () => {},
              child: Text('跳转'),
            )
          ],
        ),
      ),
    );
  }
}
