import 'package:flutter/material.dart';
import 'package:flutter_project/http/core/f_error.dart';
import 'package:flutter_project/http/dao/home_dao.dart';
import 'package:flutter_project/model/home/home_article_model.dart';
import 'package:flutter_project/widget/app_toolbar.dart';
import 'package:flutter_project/widget/article_item.dart';

class ArticlePage extends StatefulWidget {
  final int cid;
  final String? title;

  const ArticlePage({Key? key, required this.cid, this.title}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  List<ArticleInfo> articleList = [];
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData(widget.cid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: articleAppBar(widget.title!),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ArticleItem(
            articleInfo: articleList[index],
          );
        },
        itemCount: articleList.length,
      ),
    );
  }

  ///根据cid请求文章数据
  void _loadData(int cid) async {
    try {
      HomeArticleModel articleModel =
          await HomeDao.getArticleByCid(pageIndex, cid);
      List<ArticleInfo> articleList = articleModel.datas!;
      setState(() {
        this.articleList = articleList;
      });
    } on FNetError catch (e) {
      print(e);
    }
  }
}
