import 'package:flutter/material.dart';
import 'package:flutter_project/utils/color.dart';

class LoginInput extends StatefulWidget {
  final String? title;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? focusChanged;
  final bool lineStretch;
  final bool obscureText;
  final TextInputType? inputType;

  const LoginInput(
      {Key? key,
      this.title,
      this.hint,
      this.onChanged,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.inputType})
      : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title!,
                style: TextStyle(fontSize: 18),
              ),
            ),
            _input()
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: !widget.lineStretch ? 15 : 0,right: !widget.lineStretch ? 15 : 0),
          child: Divider(
            height: 1,
            thickness: 0.5,
          ),
        )
      ],
    );
  }

  _input() {
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.inputType,
      autofocus: !widget.obscureText,
      cursorColor: primary,
      style: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20, right: 20),
        border: InputBorder.none,
        hintText: widget.hint ?? '',
        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
      ),
    ));
  }
}
