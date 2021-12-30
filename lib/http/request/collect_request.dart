import 'package:flutter_project/http/request/base_request.dart';

class CollectRequest extends BaseRequest{
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;

  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return "lg/collect";
  }

}