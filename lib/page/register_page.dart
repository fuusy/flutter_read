import 'package:flutter/material.dart';
import 'package:flutter_project/http/core/f_error.dart';
import 'package:flutter_project/http/dao/login_dao.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';
import 'package:flutter_project/utils/string_util.dart';
import 'package:flutter_project/widget/app_toolbar.dart';
import 'package:flutter_project/widget/login_input.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? userName;
  String? passWord;
  String? rePassword;
  bool loginEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        FNavigator.getInstance()?.onJumpTo(RouteStatus.login);
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
            LoginInput(
              title: "确认密码",
              hint: "请输入密码",
              onChanged: (text) {
                rePassword = text;
                checkInput();
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: _loginButton(),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(passWord) &&
        isNotEmpty(rePassword)) {
      enable = true;
    } else {
      enable = false;
    }

    setState(() {
      loginEnable = enable;
    });
  }

  _loginButton() {
    return InkWell(
      onTap: () {
        if (loginEnable) {
          checkParams();
        } else {}
      },
      child: Text(
        "注册",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  void checkParams() {
    String? tips;
    if (passWord != rePassword) {
      tips = '两次密码不一致';
    }
    if (tips != null) {
      print(tips);
      return;
    }
    send();
  }

  void send() async {
    try {
      print("$userName $passWord $rePassword");
      var result =
          await LoginDao.registration(userName!, passWord!, rePassword!);
      if (result['code'] == 0) {
        print('注册成功');
        FNavigator.getInstance()?.onJumpTo(RouteStatus.login);
      } else {
        print(result['message']);
      }
    } on NeedAuth catch (e) {} on FNetError catch (e) {}
  }
}
