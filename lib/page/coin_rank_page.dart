import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/http/core/f_error.dart';
import 'package:flutter_project/http/dao/person_dao.dart';
import 'package:flutter_project/model/mine/coin_model.dart';
import 'package:flutter_project/utils/constants.dart';
import 'package:flutter_project/utils/view_util.dart';

class CoinRankPage extends StatefulWidget {
  const CoinRankPage({Key? key}) : super(key: key);

  @override
  _CoinRankPageState createState() => _CoinRankPageState();
}

class _CoinRankPageState extends State<CoinRankPage> {
  List<Coin>? coinRankList = [];

  @override
  void initState() {
    super.initState();
    _loadCoin();
  }

  Widget _buildItem(BuildContext context, int index) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            border: Border.all(width: 1, color: Colors.white)),
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(

            children: [
              Text(
                "${index + 4}",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              viewSpace(width: 20),
              Text(
                "${coinRankList![index+3].username}",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              viewSpace(width: 20),
              Expanded(child: Text(
                "积分：${coinRankList![index+3].coinCount}",
                style: TextStyle(fontSize: 20, color: Colors.black26),
              ))

            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            title: Text("排行榜",style: TextStyle(fontSize: 22,color: Colors.white),),
            backgroundColor: Colors.red,
          ),
          SliverToBoxAdapter(
              child: Container(
            height: 270,
            child: Stack(
              children: [
                Positioned(
                    top: 100,
                    left: 50,
                    child: Column(
                      children: [
                        Image(
                            width: 60,
                            height: 100,
                            image: AssetImage('images/ic_second.png')),
                        Text(
                          coinRankList!.length > 0
                              ? coinRankList![1].username!
                              : '',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          coinRankList!.length > 0
                              ? "${coinRankList![1].coinCount!}"
                              : '',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        )
                      ],
                    )),
                Positioned(
                    top: 20,
                    left: 10,
                    right: 10,
                    child: Column(
                      children: [
                        Image(
                            width: 60,
                            height: 100,
                            image: AssetImage('images/ic_first.png')),
                        Text(
                          coinRankList!.length > 0
                              ? coinRankList![0].username!
                              : '',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        Text(
                          coinRankList!.length > 0
                              ? "${coinRankList![0].coinCount!}"
                              : '',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      ],
                    )),
                Positioned(
                    top: 100,
                    right: 50,
                    child: Column(
                      children: [
                        Image(
                            width: 60,
                            height: 100,
                            image: AssetImage('images/ic_three.png')),
                        Text(
                          coinRankList!.length > 0
                              ? coinRankList![2].username!
                              : '',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          coinRankList!.length > 0
                              ? "${coinRankList![2].coinCount!}"
                              : '',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        )
                      ],
                    )),
              ],
            ),
          )),
          Container(
            child: SliverList(
              delegate: SliverChildBuilderDelegate(_buildItem,
                  childCount:
                      coinRankList!.length > 0 ? coinRankList!.length : 0),
            ),
          )
        ],
      ),
    );
  }

  ///加载积分排行榜
  void _loadCoin() async {
    try {
      CoinModel coinModel = await PersonDao.getCoinRank();
      List<Coin>? coinList = coinModel.datas;
      setState(() {
        coinRankList = coinList;
      });
    } on FNetError catch (e) {
      print(e);
    }
  }
}
