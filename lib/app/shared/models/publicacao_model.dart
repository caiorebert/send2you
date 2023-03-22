import 'package:dio/dio.dart';
import 'package:send2you/app/shared/config/config.dart';

class PublicacaoModel {

  PublicacaoModel({
    this.id,
    this.nomeUser,
    this.legenda,
    this.hora,
    this.data,
    this.createdAt,
  });

  late int? id;
  late String? nomeUser;
  late String? legenda;
  late String? hora;
  late String? data;
  late DateTime? createdAt;

  factory PublicacaoModel.fromJson(Map<String, dynamic> json) => PublicacaoModel(
      id: json['id'],
      nomeUser: json['nomeuser'],
      legenda: json['legenda'],
      hora: json['hora_publicacao'],
      data: json['data_publicacao'],
      createdAt: DateTime.parse(json['created_at']),
  );
  
  Future<bool> save() async {
    var obj = {
      "nomeUser": nomeUser,
      "legenda": legenda
    };
    Dio dio = Dio();
    Response response = await dio.post("${Config.url}/pub/new",
      data: obj
    );
    if (response.statusCode==201) {
      return true;
    } else {
      return false;
    }
  }

  String getDate(){
    final createdAt = this.createdAt;
    if (createdAt != null) {
      int day = createdAt.day;
      int month = createdAt.month;
      int year = createdAt.year;
      return "${(day < 10) ? "0$day" : "$day"}/${(month < 10) ? "0$month" : "$month"}/${year}";
    }

    return "";
  }

  String getHour(){
    return "";
  }
}