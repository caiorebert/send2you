// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversa_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConversaStore on ConversaStoreBase, Store {
  late final _$mensagensAtom =
      Atom(name: 'ConversaStoreBase.mensagens', context: context);

  @override
  ObservableList<MensagemModel> get mensagens {
    _$mensagensAtom.reportRead();
    return super.mensagens;
  }

  @override
  set mensagens(ObservableList<MensagemModel> value) {
    _$mensagensAtom.reportWrite(value, super.mensagens, () {
      super.mensagens = value;
    });
  }

  late final _$getAllMensagensAsyncAction =
      AsyncAction('ConversaStoreBase.getAllMensagens', context: context);

  @override
  Future<void> getAllMensagens(dynamic idRemetente, dynamic idDestinatario) {
    return _$getAllMensagensAsyncAction
        .run(() => super.getAllMensagens(idRemetente, idDestinatario));
  }

  late final _$ConversaStoreBaseActionController =
      ActionController(name: 'ConversaStoreBase', context: context);

  @override
  void setMensagensList(ObservableList<MensagemModel> mensagens) {
    final _$actionInfo = _$ConversaStoreBaseActionController.startAction(
        name: 'ConversaStoreBase.setMensagensList');
    try {
      return super.setMensagensList(mensagens);
    } finally {
      _$ConversaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mensagens: ${mensagens}
    ''';
  }
}
