import 'package:flutter/material.dart';
import 'package:flutter_project/http/dao/home_dao.dart';
import 'package:flutter_project/model/home/home_article_model.dart';
import 'package:flutter_project/utils/constants.dart';

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
    return FutureBuilder(future: getSearchResult(query),builder: (context,snapshot){
      if(snapshot.hasData){
        return Container(
          child: Text("${snapshot.data}"),
        );
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
