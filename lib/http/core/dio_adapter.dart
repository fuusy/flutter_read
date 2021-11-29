import 'package:dio/dio.dart';
import 'package:flutter_project/http/request/base_request.dart';
import 'package:flutter_project/http/core/f_error.dart';
import 'package:flutter_project/http/core/f_net_adapter.dart';

class DioAdapter extends FNetAdapter {
  @override
  Future<BaseNetResponse<T>> send<T>(BaseRequest request) async {
    Response? response ;
    var option = Options(headers: request.header);
    var error;

    try {
      if (request.httpMethod() == HttpMethod.GET) {
        print("${request.url()}");
        response = (await Dio().get(request.url(), options: option)) ;
      } else if (request.httpMethod() == HttpMethod.POST) {
        print("${request.url()} ${request.params} $option");
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
      throw FNetError(response?.statusCode ??-1, error.toString(),data: await buildRes(response,request));
    }

    return buildRes(response, request);
  }

  ///构建HiNetResponse
  Future<BaseNetResponse<T>> buildRes<T>(
      Response? response, BaseRequest request) {
    return Future.value(BaseNetResponse(
      //?.防止response为空
        data: response?.data,
        request: request,
        errorCode: response?.statusCode,
        errorMsg: response?.statusMessage,
        extra: response));
  }

}