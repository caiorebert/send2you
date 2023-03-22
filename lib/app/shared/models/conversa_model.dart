import 'package:send2you/app/shared/models/user_model.dart';

class ConversaModel {
  ConversaModel({
    this.id,
    this.mensagens,
    this.objUserRemetente,
    this.objUserDestinatario,
  });

  late final int ?id;
  late final List<String> ?mensagens;
  late final UserModel ?objUserRemetente;
  late final UserModel ?objUserDestinatario;

  factory ConversaModel.fromJson(Map<String, dynamic> json) => ConversaModel(
    id: json['id'],
    mensagens: json['mensagens'],
    objUserRemetente: UserModel.fromJson(json['remetente']),
    objUserDestinatario: UserModel.fromJson(json['destinario']),
  );
}