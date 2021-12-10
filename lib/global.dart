
import 'package:flutter_project/http/core/dio_adapter.dart';

class Global {


  static Future preInit() async{

    await DioAdapter.initCookJar();
  }
}