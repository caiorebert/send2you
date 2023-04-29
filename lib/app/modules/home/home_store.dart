import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:send2you/app/shared/config/config.dart';
import 'package:send2you/app/shared/elements/home/item_list_users.dart';
import 'package:send2you/app/shared/models/publicacao_model.dart';
import 'package:send2you/app/shared/models/user_model.dart';
import 'package:send2you/app/shared/routes/routes.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  UserModel user = UserModel(logged: true);

  @observable
  ObservableList<Widget> items = ObservableList<Widget>();

  @observable
  ObservableList<Widget> users = ObservableList<Widget>();

  @observable
  ObservableList<UserModel> objUsers = ObservableList<UserModel>();

  @action
  void setItems(ObservableList<Widget> list) {
    items = list;
  }

  @action
  void setUsers(ObservableList<Widget> list) {
    users = list;
  }

  @action
  void setObjUserList(ObservableList<UserModel> objList) {
    objUsers = objList;
  }

  @action
  Future<void> listItems(context) async {
    List<PublicacaoModel> list = [];
    ObservableList<Widget> listPlace = ObservableList<Widget>();
    Dio dio = Dio();
    try {
      Response response = await dio.get("${Config.url}/pub/show");
      list = (response.data as List).map((item) {
        return PublicacaoModel.fromJson(item);
      }).toList();
      for (var obj in list) {
        listPlace.add(createWidget(context, obj));
      }
      setItems(listPlace);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @action
  Future<void> listUsers(context) async {
    List<UserModel> list = [];
    ObservableList<Widget> listPlace = ObservableList<Widget>();
    ObservableList<UserModel> listObjUser = ObservableList<UserModel>();
    Dio dio = Dio();
    try {
      Response response = await dio.post(
          "${Config.url}${Routes.routes['user']!['get_users']}",
          data: {'idUser': user.id});
      list = (response.data as List).map((item) {
        return UserModel.fromJson(item);
      }).toList();
      for (var obj in list) {
        listObjUser.add(obj);
        listPlace.add(ItemListUsers(
                obj.nome.toString(),
                "https://i.pinimg.com/originals/29/47/9b/29479ba0435741580ca9f4a467be6207.png",
                obj.logged,
                context)
            .widget);
      }
      setObjUserList(listObjUser);
      setUsers(listPlace);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Widget createWidget(context, PublicacaoModel model) {
    Widget widget = Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          //color: Colors.black.withOpacity(0.5),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.white38, width: 1))),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Breezeicons-actions-22-im-user.svg/1200px-Breezeicons-actions-22-im-user.svg.png"),
                  ),
                  Expanded(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        width: double.infinity,
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(model.nomeUser!, style: const TextStyle(fontSize: 18, color: Colors.white),),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text(model.getDate(), style: const TextStyle(color: Colors.grey, fontSize: 12),),
                            )
                          ],
                        ),
                      )
                  ),
                ],
              )),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(15, 5, 0, 15),
            child: Text(
              model.legenda!,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );
    return widget;
  }
}
