import 'package:flutter_project/db/sp_cache.dart';
import 'package:flutter_project/http/request/base_request.dart';
import 'package:flutter_project/http/core/f_net.dart';
import 'package:flutter_project/http/request/login_request.dart';
import 'package:flutter_project/http/request/register_request.dart';

class LoginDao {

  static const LOGIN_TOKEN = "LOGIN_TOKEN";

  ///登录
  static login(String userName, String passWord) {
    return _send(userName, passWord);
  }

  ///注册
  static registration(String userName, String passWord, String rePassWord) {
    return _send(userName, passWord,rePassWord: rePassWord);
  }


  static _send(String userName, String passWord, {rePassWord}) async {
    BaseRequest request;
    if (rePassWord != null) {
      request = RegisterRequest();
    } else {
      request = LoginRequest();
    }
    request
        .add("username", userName)
        .add("password", passWord)
        .add("repassword", rePassWord??'');
    var result = await FNet.getInstance().fire(request);
    print("result = $result");

    if(result['code']==0 &&result['data']!=null){
      FCache.getInstance()?.setString(LOGIN_TOKEN, result['data']);
    }
    return result;
  }

  static getToken(){
    return FCache.getInstance()?.get(LOGIN_TOKEN);
  }
}
