import 'dart:convert';

import 'package:flutter_project/http/core/f_net.dart';
import 'package:flutter_project/http/request/project_request.dart';
import 'package:flutter_project/http/request/project_tab_request.dart';
import 'package:flutter_project/model/project/project_tab_model.dart';

class ProjectDao {


  ///项目模块 上方tab请求
  static getTab() async{
    ProjectTabRequest request = ProjectTabRequest();
    var result = await FNet.getInstance().fire(request);
    List tabList = result['data'];
    List<ProjectTabModel> list = tabList.map((e) {
      return new ProjectTabModel.fromJson(e);
    }).toList();

    return list;
  }
}
