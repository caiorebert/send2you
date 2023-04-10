import 'package:send2you/app/shared/models/user_model.dart';
import 'mensagem_model.dart';

class ConversaModel {
  ConversaModel({
    this.id,
    this.objUserRemetente,
    this.objUserDestinatario,
    this.mensagens
  });

  late final int ?id;
  late final UserModel ?objUserRemetente;
  late final UserModel ?objUserDestinatario;
  late final List<MensagemModel> ?mensagens;

  factory ConversaModel.fromJson(Map<String, dynamic> json) => ConversaModel(
    id: json['id'],
    mensagens: json['mensagens'],
    objUserRemetente: UserModel.fromJson(json['remetente']),
    objUserDestinatario: UserModel.fromJson(json['destinario']),
  );
}