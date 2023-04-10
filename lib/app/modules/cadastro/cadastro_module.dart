import 'package:flutter_modular/flutter_modular.dart';
import 'package:send2you/app/modules/cadastro/cadastro_page.dart';

import 'cadastro_store.dart';

class CadastroModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CadastroStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => CadastroPage())
  ];

}