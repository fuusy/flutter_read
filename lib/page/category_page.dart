import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/http/dao/project_dao.dart';
import 'package:flutter_project/model/category/category_model.dart';
import 'package:flutter_project/navigator/f_navigatior.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  List<CategoryModel> categoryList = [];
  List<Children> childList = [];

  @override
  void initState() {
    super.initState();
    _loadCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "分类",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryList[index].name!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Divider(
                  height: 1,
                  color: Colors.black26,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                        child: Wrap(
                      spacing: 12.0,
                      runSpacing: 8.0,
                      children: _buildItem(categoryList[index].children),
                    ))),
              ],
            ),
          ));
        },
        itemCount: categoryList.length,
      ),
    );
  }

  List<Widget> _buildItem(List<Children>? list) {
    return list!.map((item) {
      return Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: ActionChip(
          onPressed: () {
//跳转到相应的列表
            FRouter.getInstance()!.onIntentTo(RouteStatus.article,
                args: {"article_cid": item.id, "article_title": item.name});
          },
          label: Text(item.name!),
          elevation: 5.0,
          backgroundColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          labelStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }).toList();
  }

  void _loadCategoryList() async {
    List<CategoryModel> categoryList = await ProjectDao.getCategory();
    setState(() {
      this.categoryList = categoryList;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
