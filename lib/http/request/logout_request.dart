import 'package:flutter_project/http/request/base_request.dart';

class LogoutRequest extends BaseRequest{
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return "user/logout/json";

  }

}