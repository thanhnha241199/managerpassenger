class UserLogin {
  String username;
  String password;

  UserLogin({this.username, this.password});

  Map<String, dynamic> toDatabaseJson() =>
      {"email": this.username, "password": this.password};
}

class Token {
  String token;
  String id;
  String type;
  Token({this.token, this.id, this.type});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(token: json['token'], id: json['id'], type: json['type']);
  }
}

class User {
  int id;
  String username;
  String token;
  String type;
  User({this.id, this.username, this.token, this.type});

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
        id: data['id'],
        username: data['username'],
        token: data['token'],
        type: data['type'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "username": this.username,
        "token": this.token,
        "type": this.type
      };
}
