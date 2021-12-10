
class CoinModel {
  int? coinCount;
  int? level;
  String? nickname;
  int? rank;
  int? userId;
  String? username;

  CoinModel.fromJsonMap( dynamic map):
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