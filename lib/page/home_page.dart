import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/http/core/f_error.dart';
import 'package:flutter_project/http/core/f_net_state.dart';
import 'package:flutter_project/http/dao/home_dao.dart';
import 'package:flutter_project/model/home/banner_model.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';
import 'package:flutter_project/widget/f_banner.dart';
import 'package:flutter_project/widget/navigation_bar.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onIntentTo;

  const HomePage({Key? key, this.onIntentTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends FNetState<HomePage>
    with AutomaticKeepAliveClientMixin {
  var listener;
  List<BannerModel>? bannerList = [];

  @override
  void initState() {
    super.initState();
    FNavigator.getInstance()?.addRouteListener(
        this.listener = (curInfo, preInfo) => {print('home ${curInfo.page}')});
    _loadBanner();
  }

  @override
  void dispose() {
    super.dispose();
    FNavigator.getInstance()?.removeRouteListener(this.listener);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          NavigationBar(
            childWidget: _appBar(),
            statusStyle: StatusStyle.DARK_STYLE,
          ),
          _banner()
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _banner() {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: FBanner(
          bannerList!,
        ));
  }

  //请求banner
  void _loadBanner() async {
    try {
      List<BannerModel> banList = await HomeDao.getBanner();
      setState(() {
        bannerList?.addAll(banList);
      });
    } on FNetError catch (e) {
      print(e);
    }
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              widget.onIntentTo!(3);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image(
                height: 36,
                width: 36,
                image: AssetImage('images/default_avatar.png'),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 32,
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                decoration: BoxDecoration(color: Colors.grey[100]),
              ),
            ),
          )),
          Icon(
            Icons.message,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
