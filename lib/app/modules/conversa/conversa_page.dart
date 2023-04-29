import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobx/mobx.dart';
import 'package:send2you/app/shared/config/config.dart';
import 'package:send2you/app/shared/elements/conversa/obj_mensagem.dart';
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
  final ScrollController _scrollController = ScrollController();
  late bool firstLoading = true;
  late GlobalKey lastMensagem = GlobalKey();
  List<GlobalKey> listMensagens = <GlobalKey>[];
  bool isStopped = false;

  @override
  void initState() {
    super.initState();
    store = Modular.get<ConversaStore>();
  }

  scrollTo(GlobalKey key) async {
    final mensagem = key.currentContext!;
    await Scrollable.ensureVisible(mensagem);
  }

  Socket initSocket() {
    Socket socket = io(Config.url.substring(0, Config.url.length - 4),
        OptionBuilder().setTransports(['websocket']).build());
    socket.connect();
    socket.on(
        'newMessage',
            (data) async => {
          await store.getAllMensagens(
              widget.user!.id, widget.userDestinatario!.id, false),
        });
    return socket;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();
    MensagemModel mensagem;
    Socket socket = initSocket();
    if (store.mensagens.isEmpty && firstLoading) {
      store.getAllMensagens(widget.user!.id, widget.userDestinatario!.id, true);
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/home/",
                  arguments: {'user': widget.user});
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
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://i.pinimg.com/originals/94/65/d3/9465d39cbdcee717aa6062bc1cc144d8.jpg"))),
          child: Column(
            children: [
              Expanded(
                  child: Observer(
                      builder: (_) => (store.firstLoading.value) ?
                          const SpinKitCircle(color: Colors.red, size: 30,)
                          :
                          Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: store.mensagens.length,
                                itemBuilder: (context, index) {
                                  return ObjMensagem(context, store.mensagens[index], widget.user)
                                      .initiliazeComponent();
                                }
                              )
                            ))),
              Container(
                height: 100,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 5, 10),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: TextFormField(
                              controller: _textEditingController,
                              maxLines: 8,
                              decoration: const InputDecoration(
                                  hintText: "Digite sua mensagem..."),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        Container(
                            width: 60,
                            height: 80,
                            decoration: const BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: IconButton(
                                onPressed: () {
                                  DateTime now = DateTime.now();
                                  String hora = (now.hour.toInt() < 10)
                                      ? "0${now.hour.toString()}"
                                      : now.hour.toString();
                                  String minute = (now.minute.toInt() < 10)
                                      ? "0${now.minute.toString()}"
                                      : now.minute.toString();
                                  mensagem = MensagemModel(
                                      texto: _textEditingController.text,
                                      idUserRemetente: widget.user?.id,
                                      idUserDestinatario:
                                          widget.userDestinatario?.id,
                                      horaEnviada: "$hora:$minute");
                                  store.newMensagem(mensagem);
                                  socket.emit("message", mensagem.texto);
                                  _textEditingController.text = "";
                                },
                                icon: const Icon(Icons.send, color: Colors.white,)))
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}
