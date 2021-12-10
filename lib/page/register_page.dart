import 'package:flutter/material.dart';
import 'package:flutter_project/http/core/f_error.dart';
import 'package:flutter_project/http/core/f_net_state.dart';
import 'package:flutter_project/http/dao/login_dao.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';
import 'package:flutter_project/utils/string_util.dart';
import 'package:flutter_project/utils/toast_util.dart';
import 'package:flutter_project/widget/login_button.dart';
import 'package:flutter_project/widget/login_input.dart';

///注册页面
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends FNetState<RegisterPage> {
  String? userName;
  String? passWord;
  String? rePassword;
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
                child: Image(image: AssetImage('images/ic_login.png'),fit: BoxFit.cover,),
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
                    ),
                  ],
                ),
              )),
          Positioned(
              top: 60,
              left: 20,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios,color: Colors.white,),
              )),
        ],
      )),
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
      child: LoginButton(title: "注册", enable: loginEnable),
    );
  }

  void checkParams() {
    String? tips;
    if (passWord != rePassword) {
      tips = '两次密码不一致';
    }
    if (tips != null) {
      showToast(tips);
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
        FRouter.getInstance()?.onIntentTo(RouteStatus.login);
      } else {
        print(result['message']);
      }
    } on NeedAuth catch (e) {} on FNetError catch (e) {}
  }
}
