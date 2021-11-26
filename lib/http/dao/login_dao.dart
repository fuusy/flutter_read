import 'package:flutter_project/db/hi_cache.dart';
import 'package:flutter_project/http/request/base_request.dart';
import 'package:flutter_project/http/core/hi_net.dart';
import 'package:flutter_project/http/request/login_request.dart';
import 'package:flutter_project/http/request/register_request.dart';

class LoginDao {

  static const LOGIN_TOKEN = "LOGIN_TOKEN";

  ///登录
  static login(String userName, String passWord) {
    return _send(userName, passWord);
  }

  ///注册
  static registration(String userName, String passWord, id, orderId) {
    return _send(userName, passWord, id: id, orderId: orderId);
  }


  static _send(String userName, String passWord, {id, orderId}) async {
    BaseRequest request;
    if (id != null && orderId != null) {
      request = RegisterRequest();
    } else {
      request = LoginRequest();
    }
    request
        .add("userName", userName)
        .add("password", passWord)
        .add("imoocId", id)
        .add("orderId", orderId);
    var result = await HiNet.getInstance().fire(request);

    if(result['code']==0 &&result['data']!=null){
      HiCache.getInstance()?.setString(LOGIN_TOKEN, result['data']);
    }
    return result;
  }

  static getToken(){
    return HiCache.getInstance()?.get(LOGIN_TOKEN);
  }
}
