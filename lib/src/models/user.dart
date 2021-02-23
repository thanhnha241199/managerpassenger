class User {
  final String id;
  final String email;
  final String password;
  final String name;
  final String phone;
  final DateTime createdAt;
  final DateTime updatedAt;
  User({this.id, this.email, this.password, this.name,this.phone, this.createdAt, this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      phone: json['phone'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}