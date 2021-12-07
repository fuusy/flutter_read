import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/base/base_refresh_load_state.dart';
import 'package:flutter_project/http/core/f_error.dart';
import 'package:flutter_project/http/core/f_net_state.dart';
import 'package:flutter_project/http/dao/home_dao.dart';
import 'package:flutter_project/model/home/banner_model.dart';
import 'package:flutter_project/model/home/home_article_model.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';
import 'package:flutter_project/page/search_delegate.dart';
import 'package:flutter_project/widget/article_item.dart';
import 'package:flutter_project/widget/f_banner.dart';
import 'package:flutter_project/widget/navigation_bar.dart';

///首页
class HomePage extends StatefulWidget {
  final ValueChanged<int>? onIntentTo;

  const HomePage({Key? key, this.onIntentTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState
    extends BaseRefreshLoadStateState<HomeArticleModel, ArticleInfo, HomePage> {
  var listener;
  List<BannerModel>? bannerList = [];
  List<ArticleInfo>? articleList = [];
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    FNavigator.getInstance()?.addRouteListener(
        this.listener = (curInfo, preInfo) => {print('home ${curInfo.page}')});
    _loadBanner();
    //_loadArticle();
  }

  @override
  void dispose() {
    super.dispose();
    FNavigator.getInstance()?.removeRouteListener(this.listener);
  }

  // @override
  // Widget build(BuildContext context) {
  //   super.build(context);
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: Column(
  //       children: [
  //         NavigationBar(
  //           childWidget: _appBar(),
  //           statusStyle: StatusStyle.DARK_STYLE,
  //         ),
  //         MediaQuery.removePadding(
  //           context: context,
  //           removeTop: true,
  //           child: _buildTypeList(),
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  bool get wantKeepAlive => true;

  //bannerUI
  _banner() {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
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

  void _loadArticle() async {
    try {
      HomeArticleModel articleModel = await HomeDao.getHomeArticle(pageIndex);
      List<ArticleInfo> articleList = articleModel.datas!;
      setState(() {
        this.articleList = articleList;
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
            child: InkWell(
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
              onTap: (){
                showSearch(context: context, delegate: SearchDelegatePage());
              },
            ),
          )),
          InkWell(
            child: Icon(
              Icons.message,
              color: Colors.grey,
            ),
            onTap: (){
              //点击bar消息

            },
          )

        ],
      ),
    );
  }

  ///首页网络布局
  _gridView() {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 5, right: 5),
      child: Container(
          child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        mainAxisSpacing: 0,
        crossAxisSpacing: 5,
        crossAxisCount: 4,
        children: [
          _buildGridItem('images/icon_iv.png', '面试', cid: 73),
          _buildGridItem('images/icon_big.png', '大厂分享', cid: 510),
          _buildGridItem('images/icon_op.png', '性能优化', cid: 78),
          _buildGridItem('images/icon_daily.png', '官方发布', cid: 269),
          _buildGridItem('images/icon_jetpack.png', 'Jetpack', cid: 422),
          _buildGridItem('images/icon_open.png', '开源库源码', cid: 460),
          _buildGridItem('images/icon_framework.png', 'Framework', cid: 152),
          _buildGridItem('images/icon_kotlin.png', 'Kotlin', cid: 231),
        ],
      )),
    );
  }

  ///网格布局item
  _buildGridItem(String imgUrl, String title, {cid}) {
    return GestureDetector(
      onTap: () {
        FNavigator.getInstance()!.onIntentTo(RouteStatus.article,
            args: {"article_cid": cid, "article_title": title});
      },
      child: Column(
        children: [
          Image(
            image: AssetImage(imgUrl),
            width: 30,
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              title,
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  ///首页文章列表
  _articleView(int index) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ArticleItem(
        articleInfo: dataList[index],
      ),
    );
  }

  _buildTypeList() {
    return Container(
      child: Expanded(
          child: Container(
        child: ListView.builder(
            itemCount: dataList.length,
            controller: scrollController,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return _banner();
              } else if (index == 1) {
                return _gridView();
              } else if (index == 2) {
                return Container(
                  child: Text(
                    "热门博文",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  padding: EdgeInsets.only(left: 15, bottom: 10),
                );
              }
              return _articleView(index - 3);
            }),
      )),
    );
  }

  @override
  get child => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            NavigationBar(
              childWidget: _appBar(),
              statusStyle: StatusStyle.DARK_STYLE,
            ),
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: _buildTypeList(),
            )
          ],
        ),
      );

  @override
  Future<HomeArticleModel> getData(int curPage) async {
    HomeArticleModel articleModel = await HomeDao.getHomeArticle(curPage);
    return articleModel;
  }

  @override
  List<ArticleInfo> parseList(HomeArticleModel result) {
    return result.datas!;
  }
}
