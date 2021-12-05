import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_project/http/core/f_net_state.dart';
import 'package:flutter_project/model/mine/mine_item_model.dart';
import 'package:flutter_project/model/mine/user.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';
import 'package:flutter_project/provider/provider_manager.dart';
import 'package:flutter_project/provider/user_provider.dart';
import 'package:flutter_project/utils/cache_util.dart';
import 'package:flutter_project/utils/view_util.dart';
import 'package:flutter_project/widget/blur_view.dart';
import 'package:flutter_project/widget/setting_item.dart';
import 'package:provider/provider.dart';

///个人中心
class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends FNetState<MinePage>
    with AutomaticKeepAliveClientMixin {
  List<MineItemModel> mineItemList = [
    MineItemModel("images/icon_open.png", "我的收藏"),
    MineItemModel("images/icon_open.png", "积分排行"),
    MineItemModel("images/icon_open.png", "设置"),
    MineItemModel("images/icon_open.png", "关于"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<UserProvider>(
      builder:
          (BuildContext context, UserProvider userProvider, Widget? child) {
        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 150,
                pinned: true, //固定顶部
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  titlePadding: EdgeInsets.only(left: 0),
                  title: _buildHead(userProvider),
                  background: Stack(
                    children: [
                      Positioned.fill(
                          child: Container(
                        color: Colors.blue,
                      )),
                      Positioned.fill(
                          child: BlurView(
                        sigma: 20,
                      ))
                    ],
                  ),
                ),
              )
            ];
          },
          body: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return SettingItem(
                  iconPath: mineItemList[index].iconUrl,
                  title: mineItemList[index].title);
            },
            itemCount: mineItemList.length,
          ),
        );
      },
    ));
  }

  @override
  bool get wantKeepAlive => true;

  _buildHead([UserProvider? userProvider]) {
    User? user = userProvider!.user;
    return GestureDetector(
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(bottom: 30, left: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image(
                image: AssetImage('images/default_avatar.png'),
              ),
            ),
            viewSpace(width: 15),
            Text(
              userProvider.hasUser ? user!.nickname : "De",
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
      onTap: () {
        //是否需要登录，跳转到登录界面
        FNavigator.getInstance()!.onIntentTo(RouteStatus.login);
      },
    );
  }
}
