import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:send2you/app/shared/config/config.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'splash_store.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key? key, this.title = 'Splash'}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashStore store;

  @override
  void initState() {
    super.initState();
    store = Modular.get<SplashStore>();
  }

  @override
  Widget build(BuildContext context) {
    store.verifyCredentials(context);
    return Scaffold(
        body: Container(
          color: Colors.deepPurple,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 100,
                      ),
                      const Text(
                        "Send2You",
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: const SpinKitPulse(
                          size: 50, color: Colors.white,),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
