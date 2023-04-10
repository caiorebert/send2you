import 'package:flutter_modular/flutter_modular.dart';
import 'package:send2you/app/modules/conversa/conversa_page.dart';
import 'package:send2you/app/modules/conversa/conversa_store.dart';

class ConversaModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ConversaStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) =>
            ConversaPage(
                user: args.data['user'],
                userDestinatario: args.data['user_destinatario']
            )
    ),
  ];

}