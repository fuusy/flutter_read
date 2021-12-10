import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_project/base/base_refresh_load_state.dart';
import 'package:flutter_project/http/dao/project_dao.dart';
import 'package:flutter_project/model/project/project_model.dart';
import 'package:flutter_project/widget/card_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

///项目模块下，每个tab下的公用页面
class ProjectTabPage extends StatefulWidget {
  final int? cid;

  const ProjectTabPage({Key? key, this.cid}) : super(key: key);

  @override
  _ProjectTabPageState createState() => _ProjectTabPageState();
}

class _ProjectTabPageState extends BaseRefreshLoadStateState<ProjectModel,
    ProjectInfo, ProjectTabPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  get child => MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: StaggeredGridView.countBuilder(
          controller: scrollController,
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          crossAxisCount: 2,
          itemCount: dataList.length,
          itemBuilder: (BuildContext context, int index) {
            return CardView(
              projectInfo: dataList[index],
            );
          },
          staggeredTileBuilder: (int index) {
            return StaggeredTile.fit(1);
          }));

  @override
  Future<ProjectModel> getData(int curPage) async {
    ProjectModel projectModel =
        await ProjectDao.getProjectFromTab(curPage, widget.cid!);
    return projectModel;
  }

  @override
  List<ProjectInfo> parseList(ProjectModel result) {
    return result.datas!;
  }
}
