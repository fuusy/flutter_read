import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/http/core/f_error.dart';
import 'package:flutter_project/http/core/f_net_state.dart';
import 'package:flutter_project/http/dao/login_dao.dart';
import 'package:flutter_project/model/mine/user.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';
import 'package:flutter_project/provider/theme_provider.dart';
import 'package:flutter_project/provider/user_provider.dart';
import 'package:flutter_project/utils/color.dart';
import 'package:flutter_project/utils/string_util.dart';
import 'package:flutter_project/utils/toast_util.dart';
import 'package:flutter_project/widget/app_toolbar.dart';
import 'package:flutter_project/widget/login_button.dart';
import 'package:flutter_project/widget/login_input.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends FNetState<LoginPage> {
  String? userName;
  String? passWord;
  bool loginEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        children: [

          Positioned(
              height: 220,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image(image: AssetImage('images/ic_login.jpg'),fit: BoxFit.fill,),
              )),
          Positioned.fill(
              top: 200,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: ListView(
                  children: [
                    LoginInput(
                      title: "用户名",
                      hint: "请输入用户名",
                      onChanged: (text) {
                        userName = text;
                        checkInput();
                      },
                    ),
                    LoginInput(
                      title: "密码",
                      hint: "请输入密码",
                      onChanged: (text) {
                        passWord = text;
                        checkInput();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 50),
                      child: LoginButton(
                        title: '登录',
                        enable: loginEnable,
                        onPressed: sendLogin,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: InkWell(
                          onTap: () {
                            FNavigator.getInstance()!
                                .onIntentTo(RouteStatus.register);
                          },
                          child: Text(
                            "注册",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black26),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ],
                ),
              )),
          Positioned(
              top: 60,
              left: 20,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios,color: Colors.white,),
              )),
        ],
      )),
    );
  }

  ///检查用户名和密码是否为空等情况
  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(passWord)) {
      enable = true;
    } else {
      enable = false;
    }

    setState(() {
      loginEnable = enable;
      print('loginEnable = $loginEnable');
    });
  }

  ///登录请求发送
  void sendLogin() async {
    try {
      print("$userName $passWord ");
      var result = await LoginDao.login(userName!, passWord!);
      if (result['errorCode'] == 0) {
        print('登录成功');
        User user = User.fromJsonMap(result['data']);
        var userProvider = context.read<UserProvider>();
        userProvider.saveUser(user);

        Navigator.of(context).pop(true);
        showToast('登录成功');
      } else {
        print(result['errorMsg']);
      }
    } on NeedAuth catch (e) {} on FNetError catch (e) {}
  }
}
