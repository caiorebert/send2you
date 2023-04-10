import 'package:send2you/app/modules/conversa/conversa_module.dart';
import 'package:send2you/app/modules/conversa/conversa_store.dart';
import 'package:send2you/app/modules/home/home_store.dart';
import 'package:send2you/app/modules/login/login_module.dart';
import 'package:send2you/app/modules/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:send2you/app/modules/splash_load/splash_store.dart';

import 'modules/cadastro/cadastro_module.dart';
import 'modules/home/home_module.dart';
import 'modules/splash_load/splash_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SplashStore()),
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => ConversaStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/cadastro', module: CadastroModule()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/conversa', module: ConversaModule()),
  ];
}
