import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/project/project_model.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';
import 'package:flutter_project/utils/cache_util.dart';

class CardView extends StatelessWidget {
  final ProjectInfo? projectInfo;

  const CardView({Key? key, this.projectInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FNavigator.getInstance()?.onJumpTo(RouteStatus.webview,args: {
        "article_path": projectInfo!.link!,
        "article_title": projectInfo!.title
        });
      },
      child: SizedBox(
        height: 200,
        child: Card(
          margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_image(context), _itemTitle()],
            ),
          ),
        ),
      ),
    );
  }

  _image(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        cachedImage(projectInfo!.envelopePic!,
            width: size.width / 2 - 10, height: 120),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 5),
              decoration: BoxDecoration(
                  //渐变
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black54, Colors.transparent])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            ))
      ],
    );
  }



  _itemTitle() {
    return Expanded(
        child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            projectInfo!.title!,
            style: TextStyle(color: Colors.black54, fontSize: 16),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Icon(Icons.person),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  projectInfo!.author!,
                  style: TextStyle(fontSize: 12,color: Colors.black54),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
