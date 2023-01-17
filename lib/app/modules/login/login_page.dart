import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:send2you/app/modules/login/login_store.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/models/user_model.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerTxtLogin = TextEditingController();
  final TextEditingController _controllerTxtSenha = TextEditingController();

  late final LoginStore store;

  late bool iniciado = false;

  late bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    store = Modular.get<LoginStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black12,
            child: Column(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Icon(
                          Icons.mode_comment_sharp,
                          size: 100,
                          color: Colors.blueGrey,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Text(
                            "Send2You",
                            style: TextStyle(fontSize: 40),
                          ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    height: 80,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.10,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: const Icon(Icons.perm_identity_outlined)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          height: 60,
                          alignment: Alignment.center,
                          child: TextFormField(
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                            controller: _controllerTxtLogin,
                            decoration: const InputDecoration(hintText: "Login"),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    )),
                Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 60,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.10,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: const Icon(Icons.lock)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          height: 60,
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: _controllerTxtSenha,
                            obscureText: true,
                            decoration: const InputDecoration(hintText: "Senha"),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    )),
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        String login = _controllerTxtLogin.text.toString().trim();
                        String password =
                            _controllerTxtSenha.text.toString().trim();
                        if (login.isNotEmpty && password.isNotEmpty) {
                          setState(() {
                            _isLoading = true;
                          });
                          if (await store.logar(login, password)) {
                            store.toHome(context);
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "Preencha os campos para poder prosseguir",
                            toastLength: Toast.LENGTH_SHORT
                          );
                        }
                      },
                      label: Container(
                        padding: EdgeInsets.all(20),
                        child: const Text(
                          "ENTRAR",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      icon: _isLoading
                          ? const SizedBox(
                              height: 50,
                              child: SpinKitFadingCube(
                                color: Colors.white,
                                size: 10,
                              ))
                          : const SizedBox(
                              height: 50,
                              child: Icon(Icons.keyboard_double_arrow_right),
                            ),
                    ),
                  ),
                ),
              ],
            ),
        ),
      )
    );
  }
}
