import 'package:send2you/app/modules/login/login_module.dart';
import 'package:send2you/app/modules/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:send2you/app/pages/splash/splash_page.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: LoginModule()),
    ChildRoute('/splash', child: (_, args) => const SplashPage()),
    ModuleRoute('/home', module: HomeModule()),
  ];
}
