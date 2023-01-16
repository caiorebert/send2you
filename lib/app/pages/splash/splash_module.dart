import 'package:flutter_modular/flutter_modular.dart';
import 'splash_store.dart';

import 'splash_page.dart';
 
class SplashModule extends Module {
  @override
  final List<Bind> binds = [
 Bind.lazySingleton((i) => SplashStore()),
 ];

 @override
 final List<ModularRoute> routes = [
   ChildRoute(Modular.initialRoute, child: (_, args) => SplashPage()),
 ];
}