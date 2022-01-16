
import 'package:flutter_project/http/core/f_net.dart';
import 'package:flutter_project/http/request/coin_rank_request.dart';
import 'package:flutter_project/http/request/my_collect_request.dart';
import 'package:flutter_project/http/request/user_coin_request.dart';
import 'package:flutter_project/model/mine/coin_model.dart';
import 'package:flutter_project/model/mine/collect_model.dart';

class PersonDao{


  ///获取个人积分，需要登录
  static getUserCoin() async{
    UserCoinRequest request = UserCoinRequest();
    var result = await FNet.getInstance().fire(request);
    print("个人积分 $result");
  }

  ///我的收藏列表，需登录
  static getMyCollectList(int pageIndex) async{
    MyCollectRequest request = MyCollectRequest();
    request.pathParams="$pageIndex/json";
    var result = await FNet.getInstance().fire(request);
    return CollectModel.fromJson(result['data']);
  }

  ///积分排行榜
  static getCoinRank() async{
     CoinRankRequest request = CoinRankRequest();
     var result = await FNet.getInstance().fire(request);
     return CoinModel.fromJson(result['data']);
  }
}