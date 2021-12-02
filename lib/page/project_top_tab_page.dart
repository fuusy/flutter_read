import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_project/http/core/f_error.dart';
import 'package:flutter_project/http/core/f_net_state.dart';
import 'package:flutter_project/http/dao/project_dao.dart';
import 'package:flutter_project/model/project/project_model.dart';
import 'package:flutter_project/widget/card_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProjectTabPage extends StatefulWidget {
  final int? cid;

  const ProjectTabPage({Key? key, this.cid}) : super(key: key);

  @override
  _ProjectTabPageState createState() => _ProjectTabPageState();
}

class _ProjectTabPageState extends FNetState<ProjectTabPage>
    with AutomaticKeepAliveClientMixin {
  List<ProjectInfo> _projectList = [];
  int pagePosition = 1; //页数

  @override
  void initState() {
    super.initState();
    _loadProjectListData(widget.cid!);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: StaggeredGridView.countBuilder(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            crossAxisCount: 2,
            itemCount: _projectList.length,
            itemBuilder: (BuildContext context, int index) {
              return CardView(
                projectInfo: _projectList[index],
              );
            },
            staggeredTileBuilder: (int index) {
              return StaggeredTile.fit(1);
            }));
  }

  void _loadProjectListData(int cid, {loadMore = false}) async {
    if (!loadMore) {
      pagePosition = 1;
    }
    var curPosition = pagePosition + (loadMore ? 1 : 0);

    try {
      ProjectModel projectModel =
          await ProjectDao.getProjectFromTab(curPosition, cid);
      print('${projectModel.toString()}');
      List<ProjectInfo>? projectList = projectModel.datas;
      print('_loadProjectListData $projectList');

      setState(() {
        if (loadMore) {
          if (projectList!.isNotEmpty) {
            _projectList = [..._projectList, ...projectList];
            pagePosition++;
          }
        } else {
          _projectList = projectList ?? [];
        }
      });
    } on NeedAuth catch (e) {
      print(e);
    } on FNetError catch (e) {
      print(e);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
