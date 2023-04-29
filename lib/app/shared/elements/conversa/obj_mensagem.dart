import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:send2you/app/shared/models/mensagem_model.dart';

import '../../models/user_model.dart';

class ObjMensagem {
  ObjMensagem(this.context, this.mensagem, this.user);

  late BuildContext context;
  late MensagemModel mensagem = MensagemModel();
  late UserModel? user;
  late Widget widget;

  Widget initiliazeComponent() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.70,
      padding: EdgeInsets.fromLTRB(
          (mensagem.idUserDestinatario == user?.id) ? 10 : 0,
          0,
          (mensagem.idUserRemetente == user?.id) ? 10 : 0,
          0),
      alignment: (mensagem.idUserRemetente != user?.id)
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width * 0.70,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  width: double.infinity,
                  child: Text(mensagem.texto.toString()),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.bottomCenter,
                child: Text(
                  mensagem.horaEnviada.toString(),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          )),
    );
  }
}
