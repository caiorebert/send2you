import 'package:dio/dio.dart';
import 'package:send2you/app/shared/routes/routes.dart';

import '../config/config.dart';

class UserModel {
  UserModel({
    this.id,
    this.login,
    this.nome,
    this.password,
    required this.logged
  });

  late final int ?id;
  late final String ?login;
  late final String ?nome;
  late final String ?password;
  late final bool ?logged;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    login: json['login'],
    nome: json['nome'],
    logged: (json['logged']=="1") ? true : false
  );

  Future<Response> save() async {
    var obj = {
      "nome": nome,
      "login": login,
      "password": password
    };
    Dio dio = Dio();
    Response response = Response(requestOptions: RequestOptions(path: ""));
    try {
      response = await dio.post("${Config.url}${Routes.routes['user']!['cadastro']}",
          data: obj
      );  
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception("Erro de conexão");
      }
      throw e.response?.data['message'];
    }
    
    return response;
  }
}