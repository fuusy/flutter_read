import 'package:flutter_project/http/request/base_request.dart';

///取消收藏
class UnCollectRequest extends BaseRequest{
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
    return "lg/uncollect_originId";
  }

}