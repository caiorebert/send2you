class Routes {
  static final routes = {
    'user': {
      'login': '/user/login',
      'get_users': '/user/all',
      'cadastro': '/user/new'
    },
    'publicacao': {
      'show': '/pub/show',
      'new': '/pub/new'
    },
    'conversa': {
      'new': '/conversa/new',
      'list_mensagens': '/conversa/listaMensagens',
    }
  };

}