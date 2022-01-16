
class CoinModel {
  int? curPage;
  List<Coin>? datas;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;

  CoinModel(
      {this.curPage,
        this.datas,
        this.offset,
        this.over,
        this.pageCount,
        this.size,
        this.total});

  CoinModel.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    if (json['datas'] != null) {
      datas = new List<Coin>.empty(growable: true);
      json['datas'].forEach((v) {
        datas?.add(new Coin.fromJsonMap(v));
      });
    }
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

class Coin {
  int? coinCount;
  int? level;
  String? nickname;
  String? rank;
  int? userId;
  String? username;

  Coin.fromJsonMap( dynamic map):
        coinCount = map["coinCount"],
        level = map["level"],
        nickname = map["nickname"],
        rank = map["rank"],
        userId = map["userId"],
        username = map["username"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coinCount'] = coinCount;
    data['level'] = level;
    data['nickname'] = nickname;
    data['rank'] = rank;
    data['userId'] = userId;
    data['username'] = username;
    return data;
  }
}