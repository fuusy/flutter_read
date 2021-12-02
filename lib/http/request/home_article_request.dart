import 'package:flutter_project/http/request/base_request.dart';

///首页文章列表
///https://www.wanandroid.com/article/list/0/json
class HomeArticleRequest extends BaseRequest{
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
    return 'article/list/';
  }

}