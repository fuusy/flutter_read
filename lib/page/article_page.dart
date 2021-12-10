import 'package:flutter/material.dart';
import 'package:flutter_project/base/base_refresh_load_state.dart';
import 'package:flutter_project/http/core/f_error.dart';
import 'package:flutter_project/http/dao/home_dao.dart';
import 'package:flutter_project/model/home/home_article_model.dart';
import 'package:flutter_project/widget/app_toolbar.dart';
import 'package:flutter_project/widget/article_item.dart';

class ArticlePage extends StatefulWidget {
  final int cid;
  final String? title;

  const ArticlePage({Key? key, required this.cid, this.title})
      : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends BaseRefreshLoadStateState<HomeArticleModel,
    ArticleInfo, ArticlePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  get child => Scaffold(
        appBar: articleAppBar(widget.title!),
        body: ListView.builder(
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) {
            return ArticleItem(
              articleInfo: dataList[index],
            );
          },
          itemCount: dataList.length,
        ),
      );

  @override
  Future<HomeArticleModel> getData(int curPage) async {
    HomeArticleModel articleModel =
        await HomeDao.getArticleByCid(curPage, widget.cid);
    return articleModel;
  }

  @override
  List<ArticleInfo> parseList(HomeArticleModel result) {
    return result.datas!;
  }
}
