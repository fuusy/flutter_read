/// data : [{"desc":"一起来做个App吧","id":10,"imagePath":"https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png","isVisible":1,"order":1,"title":"一起来做个App吧","type":0,"url":"https://www.wanandroid.com/blog/show/2"},{"desc":"","id":6,"imagePath":"https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png","isVisible":1,"order":1,"title":"我们新增了一个常用导航Tab~","type":1,"url":"https://www.wanandroid.com/navi"},{"desc":"","id":20,"imagePath":"https://www.wanandroid.com/blogimgs/90c6cc12-742e-4c9f-b318-b912f163b8d0.png","isVisible":1,"order":2,"title":"flutter 中文社区 ","type":1,"url":"https://flutter.cn/"}]
/// errorCode : 0
/// errorMsg : ""

class BannerModel {
  late String desc;
  late int id;
  late String imagePath;
  late int isVisible;
  late int order;
  late String title;
  late int type;
  late String url;

  static BannerModel fromMap(Map<String, dynamic> map) {

    BannerModel dataBean = BannerModel();
    dataBean.desc = map['desc'];
    dataBean.id = map['id'];
    dataBean.imagePath = map['imagePath'];
    dataBean.isVisible = map['isVisible'];
    dataBean.order = map['order'];
    dataBean.title = map['title'];
    dataBean.type = map['type'];
    dataBean.url = map['url'];
    return dataBean;
  }

  Map toJson() => {
    "desc": desc,
    "id": id,
    "imagePath": imagePath,
    "isVisible": isVisible,
    "order": order,
    "title": title,
    "type": type,
    "url": url,
  };
}