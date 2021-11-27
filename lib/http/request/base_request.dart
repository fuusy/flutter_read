import 'package:flutter_project/http/dao/login_dao.dart';
import 'package:flutter_project/main.dart';

enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  var pathParams;
  var useHttps = true;

  //域名
  String authority() {
    return "www.wanandroid.com";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();

    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }

    if(needLogin()){
      //需要登录,请求头添加token
      addHeader(LoginDao.LOGIN_TOKEN, LoginDao.getToken());
    }
    return uri.toString();
  }

  //是否需要登录
  bool needLogin();

  Map<String, String> params = Map();

  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  //添加header
  Map<String, dynamic> header = {};

  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
