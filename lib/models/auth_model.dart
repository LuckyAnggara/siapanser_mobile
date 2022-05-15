class LoginModel {
  final String nip;
  final String password;

  LoginModel({required this.nip, required this.password});

  Map<String, dynamic> toJson() => {
        "nip": nip,
        "password": password,
      };
}

class Token {
  final String accessToken;
  final String tokenType;

  Token({required this.tokenType, required this.accessToken});

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );
}

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.role,
    this.division,
    this.status,
    this.nip,
  });

  int? id;
  String? name;
  String? role;
  Division? division;
  String? status;
  String? nip;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        role: json["role"],
        division: Division.fromJson(json["division"]),
        status: json["status"],
        nip: json["nip"],
      );
}

class Division {
  final int id;
  final String name;

  Division({required this.id, required this.name});

  factory Division.fromJson(Map<String, dynamic> json) => Division(
        id: json["id"],
        name: json["name"],
      );
}

class ChangePasswordModel {
  final String passwordLama;
  final String passwordBaru;

  ChangePasswordModel({required this.passwordLama, required this.passwordBaru});

  Map<String, dynamic> toJson() => {
        "password_lama": passwordLama,
        "password_baru": passwordBaru,
      };
}

class UserModel2 {
  UserModel2({
    this.id,
    this.name,
    this.role,
    this.divisionId,
    this.status,
    this.nip,
  });

  int? id;
  String? name;
  String? role;
  int? divisionId;
  String? status;
  String? nip;

  factory UserModel2.fromJson(Map<String, dynamic> json) => UserModel2(
        id: json["id"],
        name: json["name"],
        role: json["role"],
        divisionId: json["division_id"],
        status: json["status"],
        nip: json["nip"],
      );
}
