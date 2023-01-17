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
}