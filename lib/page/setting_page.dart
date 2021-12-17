import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/utils/color.dart';
import 'package:flutter_project/widget/app_toolbar.dart';
import 'package:flutter_project/widget/login_button.dart';

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
      body: Column(
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
    );
  }
}
