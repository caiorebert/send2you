import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:send2you/app/modules/login/login_store.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:send2you/presentation/eyes_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  late bool started = false;
  late bool _isLoading = false;
  late bool _passwordHidden = true;
  late bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    store = Modular.get<LoginStore>();
  }

  void revealPassword(){
    setState(() {
      _passwordHidden = !_passwordHidden;
    });
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
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: const Icon(
                          Icons.mode_comment_sharp,
                          size: 50,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: const Text(
                            "Send2You",
                            style: TextStyle(fontSize: 40),
                          ))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          height: 60,
                          alignment: Alignment.center,
                          child: TextFormField(
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                            controller: _controllerTxtLogin,
                            decoration: const InputDecoration(hintText: "Login"),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
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
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          height: 60,
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: _controllerTxtSenha,
                            obscureText: _passwordHidden,
                            decoration: const InputDecoration(hintText: "Senha"),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        GestureDetector(
                          onTap: revealPassword,
                          child: (_passwordHidden) ? const Icon(Eyes.eye) : const Icon(Eyes.eye_off),
                        )
                      ],
                    )),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Manter conectado"),
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            _rememberMe = !_rememberMe;
                          });
                        },
                      )
                    ]
                  ),
                ),
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: (!_isLoading) ? () async {
                        FocusScope.of(context).unfocus();
                        String login = _controllerTxtLogin.text.toString().trim().toLowerCase();
                        String password =
                            _controllerTxtSenha.text.toString().trim().toLowerCase();
                        if (login.isNotEmpty && password.isNotEmpty) {
                          setState(() {
                            _isLoading = true;
                          });
                          Response response = Response(requestOptions: RequestOptions(path: ""), statusCode: 400);
                          try {
                             response = await store.prepareLogin(login, password, _rememberMe, context);
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg: e.toString(),
                                toastLength: Toast.LENGTH_SHORT
                            );
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
                      } : () => Fluttertoast.showToast(
                          msg: "Aguarde, por favor...",
                          toastLength: Toast.LENGTH_SHORT
                      ),
                      label: Container(
                        padding: const EdgeInsets.all(20),
                        child: (!_isLoading) ? const Text(
                          "ENTRAR",
                          style: TextStyle(fontSize: 20),
                        ) : const Text("AGUARDE", style: TextStyle(fontSize: 20),),
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple.shade300, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(15))
                  ),
                  child: InkWell(
                    child:
                      const Text(
                              "Não possui login?\nClique aqui para se cadastrar",
                              style: TextStyle(fontSize: 14, color: Colors.deepPurple),
                              textAlign: TextAlign.center,
                            ),
                    onTap: () => {
                      Navigator.pushReplacementNamed(context, '/cadastro/')
                    },
                  )
                )
              ],
            ),
        ),
      )
    );
  }
}
