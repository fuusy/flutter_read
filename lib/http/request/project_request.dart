import 'package:flutter_project/http/request/base_request.dart';

class ProjectRequest extends BaseRequest{
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
    return "project/list/1/json?cid=294";
  }

}