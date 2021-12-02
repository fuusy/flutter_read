import 'package:flutter/material.dart';
import 'package:flutter_project/model/home/banner_model.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

///banner组件
///Swiper
class FBanner extends StatelessWidget {
  final List<BannerModel>? bannerList; //数据
  final double? bannerHeight; //banner高度
  final EdgeInsetsGeometry? padding;

  const FBanner(this.bannerList, {Key? key, this.bannerHeight = 110, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      key: UniqueKey(),
      itemCount: bannerList!.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerList![index]);
      },
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: DotSwiperPaginationBuilder(
              color: Colors.white60, size: 6, activeSize: 6)),
    );
  }

  _image(BannerModel bannerModel) {
    return InkWell(
      onTap: () {
        print('11');
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          child: Image.network(bannerModel.imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
