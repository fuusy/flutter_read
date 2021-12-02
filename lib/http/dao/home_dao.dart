import 'package:flutter_project/http/core/f_net.dart';
import 'package:flutter_project/http/request/banner_request.dart';
import 'package:flutter_project/http/request/home_article_request.dart';
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
}
