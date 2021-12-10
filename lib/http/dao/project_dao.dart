import 'dart:convert';

import 'package:flutter_project/http/core/f_net.dart';
import 'package:flutter_project/http/request/categoty_request.dart';
import 'package:flutter_project/http/request/project_request.dart';
import 'package:flutter_project/http/request/project_tab_request.dart';
import 'package:flutter_project/model/category/category_model.dart';
import 'package:flutter_project/model/project/project_model.dart';
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

  ///根据tab的cid分页请求项目模块数据
  static getProjectFromTab(int pagePos, int cid) async{
    ProjectRequest request = ProjectRequest();
    request.pathParams="$pagePos/json";
    request.add("cid", cid);
    var result = await FNet.getInstance().fire(request);
    return ProjectModel.fromJson(result['data']);
  }

  ///获取文章体系
  static getCategory() async {
    CategoryRequest request = CategoryRequest();
    var result = await FNet.getInstance().fire(request);
    List list = result['data'];
    List<CategoryModel> categoryList = list.map((e) {
      return CategoryModel.fromJson(e);
    }).toList();
    return categoryList;
  }
}
