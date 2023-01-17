import 'package:dio/dio.dart';
import 'package:send2you/app/shared/config/config.dart';

class PublicacaoModel {

  PublicacaoModel({
    this.id,
    this.nomeUser,
    this.legenda,
    this.createdAt,
  });

  late int? id;
  late String? nomeUser;
  late String? legenda;
  late DateTime? createdAt;

  factory PublicacaoModel.fromJson(Map<String, dynamic> json) => PublicacaoModel(
      id: json['id'],
      nomeUser: json['nomeuser'],
      legenda: json['legenda'],
      createdAt: DateTime.parse(json['created_at']),
  );
  
  Future<bool> save() async {
    var obj = {
      "nomeUser": nomeUser,
      "legenda": legenda
    };
    Response response;
    Dio dio = Dio();
    response = await dio.post("${Config.url}/pub/new",
      data: obj
    );
      return true;
  }

  String getDate(){
    return "${createdAt?.day}/${createdAt?.month}/${createdAt?.year}";
  }
}