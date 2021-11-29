import 'dart:convert';

import 'package:flutter_project/http/request/base_request.dart';



///网络请求抽象类
abstract class FNetAdapter{
  Future<BaseNetResponse<T>> send<T>(BaseRequest request);
}

///基本数据类型
class BaseNetResponse<T> {
  BaseNetResponse(
      {this.data,
      this.request,
      this.errorCode,
      this.errorMsg,
      this.extra});

  T? data;
  BaseRequest? request;
  int? errorCode;
  String? errorMsg;
  dynamic extra;

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
