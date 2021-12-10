import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_project/widget/app_toolbar.dart';

class WebViewPage extends StatefulWidget {

  final String? url;//h5链接
  final String? title;//toolbar 名称

  const WebViewPage({Key? key, this.url, this.title}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: articleAppBar(widget.title!),
      body: _buildWbContent(),
    );
  }

  _buildWbContent() {
    return Column(
      children: [
        SizedBox(
          height: 1,
          width: double.infinity,
          child: const DecoratedBox(decoration: BoxDecoration(color: Color(0xFFEEEEEE))),
        ),
        Expanded(child: InAppWebView(
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
              javaScriptEnabled: true,
            )
          ),
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url!)),


        ))
      ],
    );
  }
}
