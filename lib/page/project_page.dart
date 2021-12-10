import 'package:flutter/material.dart';
import 'package:flutter_project/http/core/f_error.dart';
import 'package:flutter_project/http/core/f_net_state.dart';
import 'package:flutter_project/http/dao/project_dao.dart';
import 'package:flutter_project/model/project/project_tab_model.dart';
import 'package:flutter_project/utils/color.dart';

import 'project_top_tab_page.dart';

///项目模块
class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends FNetState<ProjectPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  List<ProjectTabModel> projectTabList = [];

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: projectTabList.length, vsync: this);
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var top = MediaQuery.of(context).padding.top; //刘海屏 刘海的高度
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: _topTabBar(),
            color: Colors.white,
            padding: EdgeInsets.only(top: top),
          ),
          Flexible(
              child: TabBarView(
            children: projectTabList.map((tab) {
              return ProjectTabPage(cid: tab.id);
            }).toList(),
            controller: _tabController,
          ))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  ///top tab样式
  _topTabBar() {
    return TabBar(
      unselectedLabelColor: Colors.black,
      labelColor: primary,
      controller: _tabController,
      isScrollable: true,
      tabs: projectTabList.map((tab) {
        return Tab(
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              tab.name!,
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      }).toList(),
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: primary, width: 3),
          insets: EdgeInsets.only(left: 15, right: 15)),
    );
  }

  ///请求
  void loadData() async {
    try {
      List<ProjectTabModel>? tabModel = await ProjectDao.getTab();
      print('loadData $tabModel');
      if (tabModel != null) {
        _tabController = TabController(length: tabModel.length, vsync: this);
      }
      setState(() {
        projectTabList = tabModel!;
      });
    } on NeedAuth catch (e) {
      print(e);
    } on FNetError catch (e) {
      print(e);
    }
  }
}
