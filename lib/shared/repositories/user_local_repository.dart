

import 'package:agendi/models/user.dart';
import 'package:hive/hive.dart';

class UserLocalRepository{

  static void updateLocal(User user) {
    final userBox = Hive.box('user');
    userBox.put('user_key', user.toJson());
  }

  static User? getUser(){
    var item = Hive.box('user').get('user_key');
    if(item == null) return User();
    return User.fromJson(item.cast<String, dynamic>());
  }
}