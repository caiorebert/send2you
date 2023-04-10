import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:send2you/app/shared/config/config.dart';
import 'package:send2you/app/shared/models/user_model.dart';
import 'package:send2you/app/shared/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;
abstract class _LoginStoreBase with Store {

  UserModel user = UserModel(logged: false);

  void toHome(context) {
    Navigator.pushReplacementNamed(context, "/home/", arguments: {
      'user' : user
    });
  }

  Future<Response> logar(String login, String password, bool rememberMe) async {
    await Future.delayed(const Duration(seconds: 3));
    Response response = Response(
      requestOptions: RequestOptions(path: ""),
      statusCode: 400
    );
    BaseOptions options = BaseOptions(
      baseUrl: Config.url,
      connectTimeout: 3 * 1000
    );
    Dio dio = Dio(options);
    try {
      response = await dio.post('${Routes.routes['user']!['login']}',
          data: {
            "login": login,
            "password": password
          }
      );
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.connectTimeout) {
        throw Exception("Connection timeout exception");
      }
      throw ex.response?.data['message'];
    }
    if (response.statusCode==200) {
      user = UserModel(id: response.data['id'], login: response.data['login'], nome: response.data['nome'], logged: true);
      final prefs = await SharedPreferences.getInstance();
      if (rememberMe) {
        await prefs.setString("login", login);
        await prefs.setString("password", password);
      } else {
        final bool success = await prefs.remove("login");
        if (success) {
          await prefs.remove("password");
        }
      }
    }
    return response;
  }

  Future<Response> prepareLogin(String login, String password, bool rememberMe, BuildContext context) async {
    Response response = await logar(login, password, rememberMe);
    if (response.statusCode==200) {
      toHome(context);
    }
    return response;
  }
}