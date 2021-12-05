import 'package:flutter/cupertino.dart';
import 'package:flutter_project/model/mine/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  bool get hasUser => user != null;

  saveUser(User user){
    _user = user;
    notifyListeners();
  }

}
