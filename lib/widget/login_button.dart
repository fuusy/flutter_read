import 'package:flutter/material.dart';
import 'package:flutter_project/utils/color.dart';

///登录、注册界面按钮
class LoginButton extends StatelessWidget {
  final String? title;
  final bool enable;

  final VoidCallback? onPressed;

  const LoginButton({Key? key, this.title, this.enable = true, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
        onPressed: enable ? onPressed : null,
        disabledColor: Colors.grey,
        color: Colors.amber,
        child: Text(
          title!,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
