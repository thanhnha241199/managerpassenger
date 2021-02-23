class Address {
  final String id;
  final String title;
  final String address;
  final String uid;
  final String createdAt;
  final String updatedAt;
  Address({this.id, this.title, this.address, this.uid, this.createdAt, this.updatedAt});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['_id'],
      title: json['title'],
      address: json['address'],
      uid: json['uid'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'title': title,
        'address': address,
        'uid': uid,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}