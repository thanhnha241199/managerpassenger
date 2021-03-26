class TourBus {
  String id;
  String locationstart;
  String locationend;
  String time;
  String range;
  String price;
  TourBus({this.id, this.locationstart, this.locationend, this.time, this.range, this.price});

  factory TourBus.fromJson(Map<String, dynamic> json) => TourBus(
      id: json['_id'],
      locationstart: json['locationstart'],
      locationend:json['locationend'],
      time:json['time'],
      range:json['range'],
      price:json['price']);
  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'locationstart': locationstart,
        'locationend': locationend,
        'time': time,
        'range': range,
        'price': price
      };
}