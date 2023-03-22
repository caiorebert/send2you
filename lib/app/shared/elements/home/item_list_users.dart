import 'package:flutter/material.dart';

class ItemListUsers {

  late String nome;
  late String foto;
  late bool? logged;
  late BuildContext context;

  ItemListUsers(this.nome, this.foto, this.logged, this.context);

  late Widget widget =
  Container(
    alignment: Alignment.topRight,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 2,
          blurRadius: 1,
          offset: const Offset(0, 2)
        )
      ]
    ),
    margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
    height: 60,
    child: Row(
      children: [
        Container(
          height: 60,
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 1, color: Colors.black12)
            )
          ),
          padding: const EdgeInsets.all(5),
          width: (MediaQuery.of(context).size.width * 0.20) - 20,
          child: Image.network(foto),
        ),
        Container(
          height: 50,
          width: (MediaQuery.of(context).size.width * 0.70),
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(nome.toString().toLowerCase().replaceFirst(nome.toString()[0], nome.toString()[0].toUpperCase())),
        ),
        Container(
          height: 50,
          width: (MediaQuery.of(context).size.width * 0.10),
          child: Icon(Icons.circle, color: (logged != null && logged == true) ? Colors.green : Colors.red,),
        )
      ],
    ),
  );
}
