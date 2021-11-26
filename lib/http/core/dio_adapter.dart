import 'package:dio/dio.dart';
import 'package:flutter_project/http/request/base_request.dart';
import 'package:flutter_project/http/core/hi_error.dart';
import 'package:flutter_project/http/core/hi_net_adapter.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    Response? response ;
    var option = Options(headers: request.header);
    var error;

    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = (await Dio().get(request.url(), options: option)) ;
      } else if (request.httpMethod() == HttpMethod.POST) {
        response =
        (await Dio().post(request.url(), data: request.params, options: option)) ;
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = (await Dio().delete(
            request.url(), data: request.params, options: option)) ;
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }

    if (error != null) {
      throw HiNetError(response?.statusCode ??-1, error.toString(),data: await buildRes(response,request));
    }

    return buildRes(response, request);
  }

  ///构建HiNetResponse
  Future<HiNetResponse<T>> buildRes<T>(
      Response? response, BaseRequest request) {
    return Future.value(HiNetResponse(
      //?.防止response为空
        data: response?.data,
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response));
  }

}