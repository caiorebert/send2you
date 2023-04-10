import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobx/mobx.dart';
import 'package:send2you/app/shared/config/config.dart';
import 'package:send2you/app/shared/models/mensagem_model.dart';
import 'package:send2you/app/shared/models/publicacao_model.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../shared/models/user_model.dart';
import 'conversa_store.dart';

class ConversaPage extends StatefulWidget {
  final String title;
  late UserModel? user;
  late UserModel? userDestinatario;
  ConversaPage(
      {Key? key, this.title = 'Conversa', this.user, this.userDestinatario})
      : super(key: key);
  @override
  _ConversaPageState createState() => _ConversaPageState();
}

class _ConversaPageState extends State<ConversaPage> {
  late final ConversaStore store;
  late Timer timer;
  bool isStopped = false;

  @override
  void initState() {
    super.initState();
    store = Modular.get<ConversaStore>();
  }

  @override
  Widget build(BuildContext context) {
    store.getAllMensagens(widget.user!.id, widget.userDestinatario!.id);
    Socket socket = io(Config.url.substring(0, Config.url.length - 4), OptionBuilder().setTransports(['websocket']).build());
    socket.connect();
    socket.on('newMessage', (data) => {
      store.getAllMensagens(widget.user!.id, widget.userDestinatario!.id),
      print('new message')
    });
    MensagemModel mensagem;
    TextEditingController _textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/home/", arguments: {
              'user': widget.user
            });
          },
        ),
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: 30,
              child: Image.network(
                  "https://i.pinimg.com/originals/29/47/9b/29479ba0435741580ca9f4a467be6207.png"),
            ),
            Text("${widget.userDestinatario?.nome.toString()}"),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: Observer(
            builder: (_) =>
            (store.mensagens.isEmpty)
                  ? const SpinKitCircle(color: Colors.red, size: 10)
                  : Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      color: Colors.grey,
                      width: double.infinity,
                      height: double.infinity,
                      child: Observer(
                        builder: (context) => ListView.builder(
                            itemCount: store.mensagens.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.70,
                                  padding: EdgeInsets.fromLTRB(
                                      (store.mensagens[index].idUserDestinatario == widget.user?.id) ? 10 : 0,
                                      0,
                                      (store.mensagens[index].idUserRemetente == widget.user?.id) ? 10 : 0,
                                      0),
                                  alignment: (store.mensagens[index].idUserRemetente != widget.user?.id)
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: Observer(
                                    builder:
                                        (context) =>
                                            Container(
                                              alignment: Alignment.bottomCenter,
                                              width: MediaQuery.of(context).size.width * 0.70,
                                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                              decoration: const BoxDecoration(
                                                color: Colors.white
                                              ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                      child:  Container(
                                                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                        width: double.infinity,
                                                        child: Text(store.mensagens[index].texto.toString()),
                                                      ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    alignment: Alignment.bottomCenter,
                                                    child: Text(
                                                      store.mensagens[index].horaEnviada.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 12
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ),
                                  )
                              );
                            }),
                      ),
                    )
            )
          ),
          Container(
            color: Colors.grey,
            height: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(15),
            child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 5, 10),
                        width: double.infinity,
                        child: TextFormField(
                          controller: _textEditingController,
                          maxLines: 8,
                          decoration: const InputDecoration.collapsed(
                              hintText: "Digite sua mensagem..."),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    Container(
                        color: Colors.red,
                        width: 40,
                        height: 80,
                        child: IconButton(
                            onPressed: () {
                              DateTime now = DateTime.now();
                              String hora = (now.hour.toInt() < 10) ? "0${now.hour.toString()}" : now.hour.toString();
                              String minute = now.minute.toString();
                              mensagem =
                                  MensagemModel(
                                    texto: _textEditingController.text,
                                    idUserRemetente: widget.user?.id,
                                    idUserDestinatario: widget.userDestinatario?.id,
                                    horaEnviada: "$hora:$minute"
                                  );
                              store.newMensagem(mensagem);
                              socket.emit("message", mensagem.texto);
                              _textEditingController.text = "";
                            }, icon: const Icon(Icons.send)))
                  ],
                )),
          )
        ],
      ),
    );
  }
}
