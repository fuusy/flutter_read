import 'dart:convert';

import 'package:flutter_project/http/base_request.dart';



///网络请求抽象类
abstract class HiNetAdapter{
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}

///基本数据类型
class HiNetResponse<T> {
  HiNetResponse(
      {this.data,
      this.request,
      this.statusCode,
      this.statusMessage,
      this.extra});

  T? data;
  BaseRequest? request;
  int? statusCode;
  String? statusMessage;
  dynamic extra;

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
