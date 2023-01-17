import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:send2you/app/shared/config/config.dart';
import 'package:send2you/app/shared/models/user_model.dart';

part './login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;
abstract class _LoginStoreBase with Store {

  UserModel user = UserModel(logged: false);

  void toHome(context) {
    Navigator.pushReplacementNamed(context, "/home/", arguments: {
      'user' : user
    });
  }

  Future<bool> logar(String _login, String _password) async {
    await Future.delayed(Duration(seconds: 10));
    Response response;
    Dio dio = Dio();
    response = await dio.post('${Config.url}/login',
        data: {
          "login": _login,
          "password": _password
        }
    );
    if (response.statusCode==200) {
      user = UserModel(id: response.data['id'], login: response.data['login'], nome: response.data['nome'], logged: true);
      return true;
    } else if (response.statusCode==204) {
      return false;
    }
    return false;
  }
}