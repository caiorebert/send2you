import 'package:dio/dio.dart';
import 'package:send2you/app/shared/config/config.dart';
import 'package:send2you/app/shared/models/user_model.dart';
import 'package:send2you/app/shared/routes/routes.dart';

class MensagemModel {
  MensagemModel({
    this.id,
    this.texto,
    this.horaEnviada,
    this.idUserRemetente,
    this.idUserDestinatario,
  });

  late final int ?id;
  late final String ?texto;
  late final String ?createdAt;
  late final String ?horaEnviada;
  late final int ?idUserRemetente;
  late final int ?idUserDestinatario;

  factory MensagemModel.fromJson(Map<String, dynamic> json) => MensagemModel(
    id: json['id'],
    texto: json['texto'],
    horaEnviada: json['hora'],
    idUserRemetente: json['id_user_remetente'],
    idUserDestinatario: json['id_user_destinatario'],
  );
  
  Future<Response> save() async {
    Response response;
    Dio dio = Dio();
    response = await dio.post(Config.url + Routes.routes['conversa']!['new']!, data: {
      'idRemetente': idUserRemetente,
      'idDestinatario': idUserDestinatario,
      'texto': texto
    });
    return response;
  }
}