import 'package:flutter/material.dart';
import 'package:flutter_project/http/dao/home_dao.dart';
import 'package:flutter_project/model/home/home_article_model.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';

class SearchDelegatePage extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios_sharp),
        onPressed: () {
          close(context, '');
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: getSearchResult(query),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                List<ArticleInfo>? result = snapshot.data as List<ArticleInfo>?;
                return Container(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FNavigator.getInstance()!
                              .onIntentTo(RouteStatus.webview, args: {
                            "article_path": result![index].link!,
                            "article_title": result[index].title
                          });
                        },
                        child: Container(
                          height: 60,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  result![index].title!,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Divider(
                                  height: 1,
                                  color: Colors.black26,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: result?.length,
                  ),
                );
              }
              break;
          }

          return Container();
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              "",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }

  Future<List<ArticleInfo>?> getSearchResult(String query) async {
    HomeArticleModel articleModel = await HomeDao.getSearchResult(0, query);
    List<ArticleInfo>? articleList = articleModel.datas;
    return articleList;
  }
}
