import 'package:flutter_project/http/core/f_net.dart';
import 'package:flutter_project/http/request/banner_request.dart';
import 'package:flutter_project/model/home/banner_model.dart';

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
}
