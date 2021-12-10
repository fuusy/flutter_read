import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/base/base_refresh_load_state.dart';
import 'package:flutter_project/http/dao/person_dao.dart';
import 'package:flutter_project/model/mine/collect_model.dart';
import 'package:flutter_project/utils/color.dart';
import 'package:flutter_project/utils/view_util.dart';
import 'package:flutter_project/widget/app_toolbar.dart';

class MyCollectPage extends StatefulWidget {
  const MyCollectPage({Key? key}) : super(key: key);

  @override
  _MyCollectPageState createState() => _MyCollectPageState();
}

///state继承BaseRefreshLoadStateState，BaseRefreshLoadStateState是封装了刷新和下拉加载更多的框架
///[CollectModel] 相应列表model
///[Article] 列表item model，
///[MyCollectPage] 当前页面page
class _MyCollectPageState extends BaseRefreshLoadStateState<CollectModel, Article, MyCollectPage> {


  _buildItem(Article article) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title!,
            style: TextStyle(fontSize: 16, color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Container(
                  height: 20,
                  padding: EdgeInsets.only(left: 4,right: 4),
                  child: Text(
                      article.chapterName!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: primary)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: primary)),
                ),
                viewSpace(width: 10),
                Text(
                  article.niceDate!,
                  style: TextStyle(fontSize: 14, color: Colors.black26),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: Divider(
              height: 1,
              color: Colors.black26,
            ),
          )
        ],
      ),
    );
  }



  @override
  get child => Scaffold(
      appBar: articleAppBar("我的收藏"),
      body: ListView.builder(
        controller: scrollController,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(dataList[index]);
        },
        itemCount: dataList.length,
      ));

  @override
  Future<CollectModel> getData(int curPage) async{
    CollectModel model = await PersonDao.getMyCollectList(curPage);
    return model;
  }

  @override
  List<Article> parseList(CollectModel result) {
    return result.datas!;
  }
}
