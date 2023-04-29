import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:send2you/app/modules/login/login_store.dart';
import '../../shared/models/user_model.dart';
import 'cadastro_store.dart';

class CadastroPage extends StatefulWidget {
  final String title;
  CadastroPage({Key? key, this.title = 'Cadastro'}) : super(key: key);
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  late final TextEditingController nomeController = TextEditingController();
  late final TextEditingController loginController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  bool _loading = false;
  late final CadastroStore store;

  @override
  void initState() {
    super.initState();
    store = Modular.get<CadastroStore>();
  }

  @override
  Widget build(BuildContext context) {
    bool hiddenPassword = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        leading: BackButton(
          onPressed: () => {Navigator.pushReplacementNamed(context, '/')},
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        alignment: Alignment.bottomCenter,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 160,
              width: double.infinity,
              child: Icon(Icons.messenger, size: 80, color: Colors.deepPurple,),
            ),
            Container(
              height: 60,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.deepPurple.shade100),
                borderRadius: const BorderRadius.all(Radius.circular(15))
              ),
              child: const Text("Cadastro Send2You", style: TextStyle(fontSize: 30),),
            ),
            Container(
              height: 80,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                style: const TextStyle(fontSize: 20),
                controller: nomeController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.abc, size: 35,),
                    hintText: "Nome",
                    border: UnderlineInputBorder(),
                ),
              ),
            ),
            Container(
              height: 80,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                style: const TextStyle(fontSize: 20),
                controller: loginController,
                decoration: const InputDecoration(
                    hintText: "Login",
                    prefixIcon: Icon(Icons.account_circle, size: 35,),
                    border: UnderlineInputBorder()),
              ),
            ),
            Container(
              height: 80,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: passwordController,
                obscureText: hiddenPassword,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock, size: 35,),
                    hintText: "Senha",
                    border: UnderlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: (!_loading) ? () async {
                  setState(() {
                    _loading = true;
                  });
                  UserModel objUser = UserModel(
                      nome: nomeController.text.toString(),
                      login: loginController.text.toString(),
                      password: passwordController.text.toString(),
                      logged: false);
                  if (objUser.nome.toString().isEmpty || objUser.login.toString().isEmpty || objUser.password.toString().isEmpty) {
                    Fluttertoast.showToast(msg: "Todos os campos devem ser preenchidos!", toastLength: Toast.LENGTH_LONG);
                    setState(() {
                      _loading = false;
                    });
                  }
                  Response response = Response(requestOptions: RequestOptions(path: ""));
                  try {
                    response = await store.cadastrar(objUser);
                    if (response.statusCode==200) {
                      Fluttertoast.showToast(msg: "Usuário cadastrado com sucesso!", toastLength: Toast.LENGTH_LONG);
                      LoginStore loginStore = LoginStore();
                      loginStore.logar(objUser.login.toString(), objUser.password.toString(), true);
                      Navigator.pushReplacementNamed(context, "/home/", arguments: {
                        'user': objUser
                      });
                    }
                  } catch (e) {
                    Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
                  }
                  setState(() {
                    _loading = false;
                  });
                } : () => { Fluttertoast.showToast(msg: "Aguarde... Por favor!", toastLength: Toast.LENGTH_SHORT) },
                child: (_loading)
                    ? const SpinKitFadingCube(
                        color: Colors.white,
                        size: 20,
                      )
                    : const Text("CADASTRAR"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
