// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$itemsAtom = Atom(name: 'HomeStoreBase.items', context: context);

  @override
  ObservableList<Widget> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<Widget> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$usersAtom = Atom(name: 'HomeStoreBase.users', context: context);

  @override
  ObservableList<Widget> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(ObservableList<Widget> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$listItemsAsyncAction =
      AsyncAction('HomeStoreBase.listItems', context: context);

  @override
  Future<void> listItems(dynamic context) {
    return _$listItemsAsyncAction.run(() => super.listItems(context));
  }

  late final _$listUsersAsyncAction =
      AsyncAction('HomeStoreBase.listUsers', context: context);

  @override
  Future<void> listUsers(dynamic context) {
    return _$listUsersAsyncAction.run(() => super.listUsers(context));
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  void setItems(ObservableList<Widget> list) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setItems');
    try {
      return super.setItems(list);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUsers(ObservableList<Widget> list) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setUsers');
    try {
      return super.setUsers(list);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
users: ${users}
    ''';
  }
}
