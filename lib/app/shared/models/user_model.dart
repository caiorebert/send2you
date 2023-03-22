class UserModel {
  UserModel({
    this.id,
    this.login,
    this.nome,
    required this.logged
  });

  late final int ?id;
  late final String ?login;
  late final String ?nome;
  late final bool ?logged;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    login: json['login'],
    nome: json['nome'],
    logged: (json['logged']=="1") ? true : false
  );
}