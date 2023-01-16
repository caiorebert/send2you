import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'splash_store.g.dart';

class SplashStore = SplashStoreBase with _$SplashStore;

abstract class SplashStoreBase with Store {
  @observable
  int counter = 0;

  @observable
  int _selectedIndex = 0;

  List<Widget> widgetOptions = [
    Text("asd"),
    Text("asddd"),
    Text("aaaaaaaa"),
  ];

  Future<void> increment() async {
    counter = counter + 1;
  }
}