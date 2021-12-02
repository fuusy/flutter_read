import 'dart:ui';

import 'package:flutter/material.dart';

///高斯模糊组件
class BlurView extends StatelessWidget {
  final Widget? child;
  final double sigma;

  const BlurView({Key? key, this.sigma = 10, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: Container(
        color: Colors.white10,
        child: child,
      ),
    );
  }
}
