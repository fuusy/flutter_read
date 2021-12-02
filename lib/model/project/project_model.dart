


/// apkLink : ""
/// audit : 1
/// author : "manqianzhuang"
/// canEdit : false
/// chapterId : 294
/// chapterName : "完整项目"
/// collect : false
/// courseId : 13
/// desc : "项目使用Android官方的Jetpack Compose完成，遵循MVVM架构思路，以下为本项目用到的框架：\r\njetpack compose, viewModel, retrofit, okhttp, coroutine/flow, paging3，\r\nroom, accompanist, hilt, gson, glide/picasso, navigation."
/// descMd : ""
/// envelopePic : "https://www.wanandroid.com/resources/image/pc/default_project_img.jpg"
/// fresh : false
/// host : ""
/// id : 20275
/// link : "https://www.wanandroid.com/blog/show/3090"
/// niceDate : "2021-10-24 22:51"
/// niceShareDate : "2021-10-24 22:51"
/// origin : ""
/// prefix : ""
/// projectLink : "https://github.com/manqianzhuang/HamApp.git"
/// publishTime : 1635087073000
/// realSuperChapterId : 293
/// selfVisible : 0
/// shareDate : 1635087073000
/// shareUser : ""
/// superChapterId : 294
/// superChapterName : "开源项目主Tab"
/// tags : [{"name":"项目","url":"/project/list/1?cid=294"}]
/// title : "用Jetpack Compose做一个完成度较高的WanAndroid app"
/// type : 0
/// userId : -1
/// visible : 1
/// zan : 0

class ProjectModel {
  int? curPage;
  List<ProjectInfo>? datas;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;

  ProjectModel(
      {this.curPage,
        this.datas,
        this.offset,
        this.over,
        this.pageCount,
        this.size,
        this.total});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    print("fromJson111 = ${json['datas']}");
    if (json['datas'] != null) {
      datas = new List<ProjectInfo>.empty(growable: true);
      json['datas'].forEach((v) {
        datas?.add(new ProjectInfo.fromJson(v));
      });
    }
    print("fromJson = ${datas}");
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curPage'] = this.curPage;
    if (this.datas != null) {
      data['datas'] = this.datas?.map((v) => v.toJson()).toList();
    }
    data['offset'] = this.offset;
    data['over'] = this.over;
    data['pageCount'] = this.pageCount;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}

class ProjectInfo {
  String? apkLink;
  int? audit;
  String? author;
  bool? canEdit;
  int? chapterId;
  String? chapterName;
  bool? collect;
  int? courseId;
  String? desc;
  String? descMd;
  String? envelopePic;
  bool? fresh;
  String? host;
  int? id;
  String? link;
  String? niceDate;
  String? niceShareDate;
  String? origin;
  String? prefix;
  String? projectLink;
  int? publishTime;
  int? realSuperChapterId;
  int? selfVisible;
  int? shareDate;
  String? shareUser;
  int? superChapterId;
  String? superChapterName;
  List<Tags>? tags;
  String? title;
  int? type;
  int? userId;
  int? visible;
  int? zan;

  ProjectInfo(
      {this.apkLink,
        this.audit,
        this.author,
        this.canEdit,
        this.chapterId,
        this.chapterName,
        this.collect,
        this.courseId,
        this.desc,
        this.descMd,
        this.envelopePic,
        this.fresh,
        this.host,
        this.id,
        this.link,
        this.niceDate,
        this.niceShareDate,
        this.origin,
        this.prefix,
        this.projectLink,
        this.publishTime,
        this.realSuperChapterId,
        this.selfVisible,
        this.shareDate,
        this.shareUser,
        this.superChapterId,
        this.superChapterName,
        this.tags,
        this.title,
        this.type,
        this.userId,
        this.visible,
        this.zan});

  ProjectInfo.fromJson(Map<String, dynamic> json) {
    apkLink = json['apkLink'];
    audit = json['audit'];
    author = json['author'];
    canEdit = json['canEdit'];
    chapterId = json['chapterId'];
    chapterName = json['chapterName'];
    collect = json['collect'];
    courseId = json['courseId'];
    desc = json['desc'];
    descMd = json['descMd'];
    envelopePic = json['envelopePic'];
    fresh = json['fresh'];
    host = json['host'];
    id = json['id'];
    link = json['link'];
    niceDate = json['niceDate'];
    niceShareDate = json['niceShareDate'];
    origin = json['origin'];
    prefix = json['prefix'];
    projectLink = json['projectLink'];
    publishTime = json['publishTime'];
    realSuperChapterId = json['realSuperChapterId'];
    selfVisible = json['selfVisible'];
    shareDate = json['shareDate'];
    shareUser = json['shareUser'];
    superChapterId = json['superChapterId'];
    superChapterName = json['superChapterName'];
    if (json['tags'] != null) {
      tags = new List<Tags>.empty(growable: true);
      json['tags'].forEach((v) {
        tags?.add(new Tags.fromJson(v));
      });
    }
    title = json['title'];
    type = json['type'];
    userId = json['userId'];
    visible = json['visible'];
    zan = json['zan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apkLink'] = this.apkLink;
    data['audit'] = this.audit;
    data['author'] = this.author;
    data['canEdit'] = this.canEdit;
    data['chapterId'] = this.chapterId;
    data['chapterName'] = this.chapterName;
    data['collect'] = this.collect;
    data['courseId'] = this.courseId;
    data['desc'] = this.desc;
    data['descMd'] = this.descMd;
    data['envelopePic'] = this.envelopePic;
    data['fresh'] = this.fresh;
    data['host'] = this.host;
    data['id'] = this.id;
    data['link'] = this.link;
    data['niceDate'] = this.niceDate;
    data['niceShareDate'] = this.niceShareDate;
    data['origin'] = this.origin;
    data['prefix'] = this.prefix;
    data['projectLink'] = this.projectLink;
    data['publishTime'] = this.publishTime;
    data['realSuperChapterId'] = this.realSuperChapterId;
    data['selfVisible'] = this.selfVisible;
    data['shareDate'] = this.shareDate;
    data['shareUser'] = this.shareUser;
    data['superChapterId'] = this.superChapterId;
    data['superChapterName'] = this.superChapterName;
    if (this.tags != null) {
      data['tags'] = this.tags?.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['type'] = this.type;
    data['userId'] = this.userId;
    data['visible'] = this.visible;
    data['zan'] = this.zan;
    return data;
  }
}

class Tags {
  String? name;
  String? url;

  Tags({this.name, this.url});

  Tags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}