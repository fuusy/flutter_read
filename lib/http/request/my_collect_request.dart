
import 'package:flutter_project/http/request/base_request.dart';

class MyCollectRequest extends BaseRequest{
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
    return "lg/collect/list";
  }

}