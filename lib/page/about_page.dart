import 'package:flutter/material.dart';
import 'package:flutter_project/widget/app_toolbar.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: articleAppBar("关于"),
      body: Container(
        alignment: Alignment.topCenter,
        child: Padding(padding: EdgeInsets.only(top: 130),
        child: Image.asset("images/ic_flutter.png",width: 100,height: 100,),)

      ),
    );
  }
}
