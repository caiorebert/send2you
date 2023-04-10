import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/models/user_model.dart';
import '../login/login_store.dart';
part 'splash_store.g.dart';

class SplashStore = SplashStoreBase with _$SplashStore;

abstract class SplashStoreBase with Store {

  UserModel user = UserModel(logged: false);
  LoginStore loginStore = LoginStore();

  void verifyCredentials(context) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final login = _prefs.getString("login");
    final password = _prefs.getString("password");
    if (login != null) {
      if (password != null) {
        Response response = Response(requestOptions: RequestOptions(path: ""), statusCode: 400);
        try {
           response = await loginStore.logar(
              login, password, (login.isNotEmpty && password.isNotEmpty));
        } catch (e) {
          Navigator.pushReplacementNamed(context, "/login/");
        }
        if (response.statusCode==200) {
          Navigator.pushReplacementNamed(context, "/home/", arguments: {
            'user' : loginStore.user
          });
        }
      } else {
        Navigator.pushReplacementNamed(context, "/login/");
      }
    } else {
      Navigator.pushReplacementNamed(context, "/login/");
    }
  }
}