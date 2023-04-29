import 'package:flutter/material.dart';
import 'package:send2you/app/shared/elements/home/item_list_users.dart';

class ListUsers {

  late List<ItemListUsers> nome;
  late String foto;
  late bool? logged;
  late BuildContext context;

  ListUsers(this.nome, this.foto, this.logged, this.context);

  late Widget widget = Container();
}
