import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../shared/config/config.dart';
import '../../shared/models/mensagem_model.dart';
import '../../shared/routes/routes.dart';

part 'conversa_store.g.dart';

class ConversaStore = ConversaStoreBase with _$ConversaStore;

abstract class ConversaStoreBase with Store {

  @observable
  ObservableList<MensagemModel> mensagens = ObservableList<MensagemModel>();

  @action
  void setMensagensList(ObservableList<MensagemModel> mensagens){
    this.mensagens = mensagens;
  }
  @action
  void addMensagem(MensagemModel mensagem){
    mensagens.add(mensagem);
  }

  @action
  Future<void> getAllMensagens(idRemetente, idDestinatario) async {
    await Future.delayed(const Duration(seconds: 3));
    Response response;
    Dio dio = Dio();
    try {
      response = await dio.post('${Config.url}${Routes.routes['conversa']!['list_mensagens']}',
          data: {
            "idRemetente": idRemetente,
            "idDestinatario": idDestinatario
          }
      );
      ObservableList<MensagemModel> listPlace = ObservableList<MensagemModel>();
      List<MensagemModel> mensagens = (response.data as List).map((item) { return MensagemModel.fromJson(item); }).toList();

      for(MensagemModel obj in mensagens) {
        listPlace.add(obj);
      }
      setMensagensList(listPlace);
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<Response> newMensagem(MensagemModel mensagem) async {
    addMensagem(mensagem);
    return mensagem.save();
  }
}