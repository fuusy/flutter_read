

///需要登录
class NeedLogin extends FNetError {
  NeedLogin({int code: 401, String message: '请先登录'}) : super(code, message);
}

///需要授权的异常
class NeedAuth extends FNetError {
  NeedAuth(String message, {int code: 403, dynamic data})
      : super(code, message);
}

class FNetError implements Exception {
  final int? code;
  final String message;
  final dynamic data;

  FNetError(this.code, this.message, {this.data});
}
