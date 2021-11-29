import 'package:flutter/material.dart';
import 'package:flutter_project/http/core/f_error.dart';
import 'package:flutter_project/http/core/f_net_state.dart';
import 'package:flutter_project/http/dao/login_dao.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';
import 'package:flutter_project/utils/string_util.dart';
import 'package:flutter_project/utils/toast_util.dart';
import 'package:flutter_project/widget/app_toolbar.dart';
import 'package:flutter_project/widget/login_button.dart';
import 'package:flutter_project/widget/login_input.dart';

class LoginPage extends StatefulWidget {


  const LoginPage({Key? key})
      : super(key: key);

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
      appBar: appBar("密码登录", "注册", (){
        FNavigator.getInstance()?.onJumpTo(RouteStatus.register);
      }),
      body: Container(
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
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: LoginButton(
                title: '登录',
                enable: loginEnable,
                onPressed: sendLogin,
              ),
            )
          ],
        ),
      ),
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
      if (result['code'] == 0) {
        print('登录成功');
        showToast('登录成功');
        FNavigator.getInstance()?.onJumpTo(RouteStatus.home);
      } else {
        print(result['message']);
      }
    } on NeedAuth catch (e) {} on FNetError catch (e) {}
  }
}
