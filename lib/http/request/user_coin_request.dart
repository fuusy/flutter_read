import 'package:flutter_project/http/request/base_request.dart';

///个人积分
class UserCoinRequest extends BaseRequest{
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
    return "lg/coin/userinfo/json";
  }

}