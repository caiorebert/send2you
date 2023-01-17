import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:send2you/app/shared/config/config.dart';
import 'package:send2you/app/shared/models/publicacaoModel.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {

  @observable
  ObservableList<Widget> items = ObservableList<Widget>();

  @action
  void setItems(ObservableList<Widget> list) {
    items = list;
  }

  @action
  Future<void> listItems(context) async {
    List<PublicacaoModel> list = [];
    ObservableList<Widget> listPlace = ObservableList<Widget>();
    Dio dio = Dio();
    try {
      Response response = await dio.get("${Config.url}/pub/show");
      list = (response.data as List).map((item) { return PublicacaoModel.fromJson(item);}).toList();
      for(var obj in list) {
        listPlace.add(createWidget(context, obj));
      }
      setItems(listPlace);
    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Widget createWidget(context, PublicacaoModel model) {
    Widget widget =
    Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(0, 3),
                blurRadius: 7,
                spreadRadius: 5
            )
          ]
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                  width: 1
                )
              )
            ),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: 40,
                  child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Breezeicons-actions-22-im-user.svg/1200px-Breezeicons-actions-22-im-user.svg.png"),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: Text(model.nomeUser!),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  alignment: Alignment.topRight,
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Text(model.getDate()),
                )
              ],
            )
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 10),
            child: Text(model.legenda!, style: const TextStyle(color: Colors.black),),
          )
        ],
      ),
    );
    return widget;
  }

}