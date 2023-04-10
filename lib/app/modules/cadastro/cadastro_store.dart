import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../shared/config/config.dart';
import '../../shared/models/mensagem_model.dart';
import '../../shared/models/user_model.dart';
import '../../shared/routes/routes.dart';

part 'cadastro_store.g.dart';

class CadastroStore = CadastroStoreBase with _$CadastroStore;

abstract class CadastroStoreBase with Store {
  Future<Response> cadastrar(UserModel user) async {
    Response response = Response(requestOptions: RequestOptions(path: ""));
    await Future.delayed(const Duration(seconds: 5), () async => response = await user.save());
    return response;
  }
}