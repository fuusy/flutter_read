import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          decoration: new BoxDecoration(
            border: Border.all(color: Colors.grey,width: 1.0),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0))
          ),
          height: 36,

        ),
      ),

    );
  }
}
