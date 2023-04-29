// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversa_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConversaStore on ConversaStoreBase, Store {
  late final _$loadingAtom =
      Atom(name: 'ConversaStoreBase.loading', context: context);

  @override
  Observable<bool> get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(Observable<bool> value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

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

  late final _$firstLoadingAtom =
      Atom(name: 'ConversaStoreBase.firstLoading', context: context);

  @override
  Observable<bool> get firstLoading {
    _$firstLoadingAtom.reportRead();
    return super.firstLoading;
  }

  @override
  set firstLoading(Observable<bool> value) {
    _$firstLoadingAtom.reportWrite(value, super.firstLoading, () {
      super.firstLoading = value;
    });
  }

  late final _$getAllMensagensAsyncAction =
      AsyncAction('ConversaStoreBase.getAllMensagens', context: context);

  @override
  Future<void> getAllMensagens(
      dynamic idRemetente, dynamic idDestinatario, dynamic firstLoading) {
    return _$getAllMensagensAsyncAction.run(
        () => super.getAllMensagens(idRemetente, idDestinatario, firstLoading));
  }

  late final _$newMensagemAsyncAction =
      AsyncAction('ConversaStoreBase.newMensagem', context: context);

  @override
  Future<Response<dynamic>> newMensagem(MensagemModel mensagem) {
    return _$newMensagemAsyncAction.run(() => super.newMensagem(mensagem));
  }

  late final _$ConversaStoreBaseActionController =
      ActionController(name: 'ConversaStoreBase', context: context);

  @override
  void setLoading(bool val) {
    final _$actionInfo = _$ConversaStoreBaseActionController.startAction(
        name: 'ConversaStoreBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$ConversaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

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
  void addMensagem(MensagemModel mensagem) {
    final _$actionInfo = _$ConversaStoreBaseActionController.startAction(
        name: 'ConversaStoreBase.addMensagem');
    try {
      return super.addMensagem(mensagem);
    } finally {
      _$ConversaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
mensagens: ${mensagens},
firstLoading: ${firstLoading}
    ''';
  }
}
