import 'package:flutter_project/http/core/f_net.dart';
import 'package:flutter_project/http/request/banner_request.dart';
import 'package:flutter_project/http/request/collect_request.dart';
import 'package:flutter_project/http/request/home_article_request.dart';
import 'package:flutter_project/http/request/search_request.dart';
import 'package:flutter_project/model/home/banner_model.dart';
import 'package:flutter_project/model/home/home_article_model.dart';

class HomeDao {
  ///首页banner请求
  static getBanner() async {
    BannerRequest request = new BannerRequest();
    var result = await FNet.getInstance().fire(request);
    List list = result['data'];
    List<BannerModel> bannerList = list.map((e) {
      return BannerModel.fromMap(e);
    }).toList();
    return bannerList;
  }

  ///从0开始
  ///请求首页文章列表
  static getHomeArticle(int pageIndex) async{
    HomeArticleRequest request = new HomeArticleRequest();
    request.pathParams = '$pageIndex/json';
    var result = await FNet.getInstance().fire(request);
    return HomeArticleModel.fromJson(result['data']);
  }

  ///根据cid请求文章
  static getArticleByCid(int pageIndex,int cid) async{
    HomeArticleRequest request = new HomeArticleRequest();
    request.pathParams = "$pageIndex/json";
    request.add("cid",cid);
    var result = await FNet.getInstance().fire(request);
    return HomeArticleModel.fromJson(result['data']);
  }

  ///获取搜素结果
  static getSearchResult(int pageIndex,String query) async{
    SearchRequest request = SearchRequest();
    request.pathParams = '/$pageIndex/json';
    request.add("k", query);
    var result = await FNet.getInstance().fire(request);
    print("搜索结果 $result");
    return HomeArticleModel.fromJson(result['data']);
  }

  ///收藏文章
  static collectArticle(int id) async{
    CollectRequest request = CollectRequest();
    request.pathParams = "/$id/json";
    var result = await FNet.getInstance().fire(request);
    print("收藏： $result");
    return result;
  }
}
