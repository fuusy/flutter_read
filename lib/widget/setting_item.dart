import 'package:flutter/material.dart';
import 'package:flutter_project/http/dao/person_dao.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';
import 'package:flutter_project/utils/view_util.dart';

///个人中心Item组件
///包含icon和title
class SettingItem extends StatelessWidget {
  final String? iconPath;
  final String? title;
  final int? index;

  const SettingItem({Key? key, this.iconPath, this.title, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          switch (index) {
            case 0:
              //我的收藏
              FRouter.getInstance()!.onIntentTo(RouteStatus.collect);
              break;
          }
        },
        child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(top: 5, bottom: 5),
            height: 70,
            decoration: BoxDecoration(border: borderLine(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image(
                      image: AssetImage(iconPath!),
                      height: 30,
                      width: 30,
                    ),
                    viewSpace(width: 30),
                    Text(title!, style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            )));
  }
}
