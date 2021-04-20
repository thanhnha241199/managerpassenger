class Discount {
  String sId;
  String title;
  int sale;
  String timestart;
  String timeend;
  String code;
  String description;
  String createdAt;
  String updatedAt;

  Discount(
      {this.sId,
      this.title,
      this.sale,
      this.timestart,
      this.timeend,
      this.code,
      this.description,
      this.createdAt,
      this.updatedAt});

  Discount.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    sale = json['sale'];
    timestart = json['timestart'];
    timeend = json['timeend'];
    code = json['code'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['sale'] = this.sale;
    data['timestart'] = this.timestart;
    data['timeend'] = this.timeend;
    data['code'] = this.code;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
