import 'package:flutter/material.dart';
import 'package:flutter_project/http/core/f_error.dart';
import 'package:flutter_project/http/core/f_net_state.dart';
import 'package:flutter_project/utils/color.dart';

///下拉刷新，上拉加载更多框架
///[M]json请求结果实体类
///[L]列表数据实体类
///[T]StatefulWidget，例如首页page
abstract class BaseRefreshLoadStateState<M, L, T extends StatefulWidget>
    extends FNetState<T> with AutomaticKeepAliveClientMixin {
  List<L> dataList = [];
  int pagePos = 0;
  bool loading = false;
  ScrollController scrollController = ScrollController();

  get child;

  @override
  void initState() {
    super.initState();
    //上拉加载更多
    scrollController.addListener(() {
      var distance = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      //距离下方300，且足一屏才加载更多
      if (distance < 300 &&
          !loading &&
          scrollController.position.maxScrollExtent != 0) {
        loadData(isLoadMore: true);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      onRefresh: loadData,
      color: primary,
    );
  }

  Future<void> loadData({isLoadMore = false}) async {
    if (loading) {
      return;
    }
    loading = true;
    if (!isLoadMore) {
      pagePos = 0;
    }

    var curPage = pagePos + (isLoadMore ? 1 : 0);
    try {
      var result = await getData(curPage);
      setState(() {
        if (isLoadMore) {
          dataList = [...dataList, ...parseList(result)];
          if (parseList(result).length != 0) {
            pagePos++;
          }
        } else {
          dataList = parseList(result);
        }
      });
      Future.delayed(Duration(milliseconds: 1000), () {
        loading = false;
      });
    } on FNetError catch (e) {
      loading = false;
      print(e);
    }
  }

  Future<M> getData(int curPage);

  List<L> parseList(M result);

  @override
  bool get wantKeepAlive => true;
}
