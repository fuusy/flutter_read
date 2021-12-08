import 'package:flutter/material.dart';
import 'package:flutter_project/model/home/home_article_model.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';

///文章list item组件
class ArticleItem extends StatelessWidget {
  final ArticleInfo? articleInfo;

  const ArticleItem({Key? key, this.articleInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,//空白处点击响应
      onTap: () {
        FNavigator.getInstance()!.onIntentTo(RouteStatus.webview, args: {
          "article_path": articleInfo!.link!,
          "article_title": articleInfo!.title
        });
      },
      child: Container(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
          height: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                articleInfo!.title!,
                style: TextStyle(fontSize: 16, color: Colors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Image(
                    image: AssetImage('images/ic_un_favorite.png'),
                    width: 20,
                    height: 20,
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      articleInfo!.shareUser!,
                      style: TextStyle(fontSize: 12, color: Colors.black26),
                    ),
                  ))
                ],
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              Divider(
                height: 1,
                color: Colors.black26,
              )
            ],
          )),
    );
  }
}
