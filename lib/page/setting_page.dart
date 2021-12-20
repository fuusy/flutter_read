import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/db/sp_cache.dart';
import 'package:flutter_project/http/dao/login_dao.dart';
import 'package:flutter_project/provider/user_provider.dart';
import 'package:flutter_project/utils/color.dart';
import 'package:flutter_project/widget/app_toolbar.dart';
import 'package:flutter_project/widget/login_button.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: articleAppBar("设置"),
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "暗黑模式",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Switch(
                        onChanged: (bool value) {
                          setState(() {
                            flag = value;
                          });
                        },
                        value: flag,
                        activeColor: primary,
                      )
                    ],
                  ),
                  Divider(
                    height: 1,
                    color: Colors.black26,
                  ),
                ],
              ),
              Positioned(
                  bottom: 60,
                  left: 40,
                  right: 40,
                  child: Container(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        height: 50,
                        disabledColor: Colors.grey.shade300,
                        color: primary,
                        onPressed: () {
                          _showDialog();
                        },
                        child: Text(
                          "退出登录",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )))
            ],
          ),
        ));
  }

  void _showDialog() {
    CupertinoAlertDialog dialog = CupertinoAlertDialog(
      content: Text(
        "确定是否退出登录？",
        style: TextStyle(fontSize: 14),
      ),
      actions: [
        TextButton(onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        }, child: Text("取消")),
        TextButton(onPressed: () {
          _sendLogout();
        }, child: Text("确定")),
      ],
    );
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  void _sendLogout() async {
    LoginDao.logout();
    SpCache.getInstance()!.clearLoginInfo();
    var userProvider = context.read<UserProvider>();
    userProvider.clearUser();
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.of(context).pop();
  }
}
