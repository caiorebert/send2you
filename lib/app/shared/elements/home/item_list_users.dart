import 'package:flutter/material.dart';

class ItemListUsers {

  late String nome;
  late String foto;
  late bool? logged;
  late BuildContext context;

  ItemListUsers(this.nome, this.foto, this.logged, this.context);

  late Widget widget =
  Container(
    width: double.infinity,
    alignment: Alignment.topRight,
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.deepPurple, width: 1)),
    ),
    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    //padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
          width: 60,
          child: Image.network(foto),
        ),
        Expanded(
            child: Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child:
                Text(
                  nome.toString().replaceFirst(nome.toString()[0], nome.toString()[0].toUpperCase()),
                  style: const TextStyle(color: Colors.white),
                ),
            ),
        ),
      ],
    ),
  );
}
