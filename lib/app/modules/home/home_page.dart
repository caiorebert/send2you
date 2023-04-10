import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobx/mobx.dart';
import 'package:send2you/app/shared/models/publicacao_model.dart';
import '../../shared/models/user_model.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  final UserModel? user;
  const HomePage({Key? key, this.title = 'Home', this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final HomeStore store;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    store = Modular.get<HomeStore>();
    store.user = widget.user!;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
        const Duration(seconds: 2000), (Timer t) => store.listItems(context));
    TextEditingController controllerEdtPub = TextEditingController();
    store.items = ObservableList<Widget>();
    store.users = ObservableList<Widget>();
    store.listItems(context);
    store.listUsers(context);
    List<Widget> widgetOptions = [
      Container(
        color: Colors.white,
        alignment: Alignment.topLeft,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      controller: controllerEdtPub,
                      decoration: const InputDecoration.collapsed(
                          hintText: "Escreva o que pensa..."),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        PublicacaoModel obj = PublicacaoModel();
                        obj.nomeUser = widget.user?.nome;
                        obj.legenda = controllerEdtPub.text.toString();
                        controllerEdtPub.text = "";
                        controllerEdtPub.clear();
                        if (await obj.save()) {
                          store.listItems(context);
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Text("PUBLICAR"),
                      ))
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: const Text(
                "Atualizações recentes",
                style: TextStyle(color: Colors.black26),
              ),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width,
                child: RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(const Duration(seconds: 1), (){
                      store.listItems(context);
                    });
                  },
                  child: Observer(
                    builder: (context) => (store.items.isEmpty)
                        ? const SpinKitCircle(
                            color: Colors.blueAccent,
                            size: 50,
                          )
                        : Observer(
                            builder: (context) => ListView.builder(
                                itemCount: store.items.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 10, 5, 15),
                                    child: Observer(
                                        builder: (context) =>
                                            store.items[index]),
                                  );
                                }),
                          ),
                  ),
                ))
          ],
        ),
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.84,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 50,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              color: Colors.white24,
              child: const Text("LISTA DE USUÁRIOS"),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.77,
              width: MediaQuery.of(context).size.width,
              child: Observer(
                builder: (_) => ListView.builder(
                  itemCount: store.users.length,
                  itemBuilder: (_, index) {
                    return Observer(
                      builder: (_) {
                        return GestureDetector(
                          onTap: () => {
                            Navigator.pushReplacementNamed(context, '/conversa/', arguments: {
                              'user': widget.user,
                              'user_destinatario': store.objUsers[index]
                            })
                          },
                          child: store.users[index],
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ]
        ),
      )
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Send2You'),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topLeft,
            child: widgetOptions.elementAt(_selectedIndex),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          child: BottomNavigationBar(
            unselectedItemColor: Colors.white70,
            backgroundColor: Colors.black,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_alt), label: 'Pessoas'),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ));
  }
}
