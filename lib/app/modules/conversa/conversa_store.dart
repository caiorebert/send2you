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
  Observable<bool> loading = Observable(false);

  @observable
  ObservableList<MensagemModel> mensagens = ObservableList<MensagemModel>();

  @observable
  Observable<bool> firstLoading = Observable<bool>(true);

  @action
  void setLoading(bool val) {
    firstLoading = Observable<bool>(val);
  }

  @action
  void setMensagensList(ObservableList<MensagemModel> mensagens){
    this.mensagens.clear();
    this.mensagens.addAll(mensagens);
  }
  @action
  void addMensagem(MensagemModel mensagem){
    mensagens.add(mensagem);
  }

  @action
  Future<void> getAllMensagens(idRemetente, idDestinatario, firstLoading) async {
    setLoading(true);
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
      if (firstLoading) {
        for(MensagemModel obj in mensagens) {
          listPlace.add(obj);
        }
        setMensagensList(listPlace);
      } else {
        this.mensagens.clear();
        for(MensagemModel obj in mensagens) {
          addMensagem(obj);
        }
      }
      setLoading(false);
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