import 'package:flutter_project/http/request/base_request.dart';

class CoinRankRequest extends BaseRequest{
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "coin/rank/1/json";
  }

}