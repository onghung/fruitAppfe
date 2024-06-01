class Cart {
  Datetime? datetime;
  String? name;
  int? price;
  int? quantity;
  String? status;
  String? user;
  String? imgurl;

  Cart(
      {this.datetime,
        this.name,
        this.price,
        this.quantity,
        this.status,
        this.user,
        this.imgurl});

  Cart.fromJson(Map<String, dynamic> json) {
    datetime = json['datetime'] != null
        ? new Datetime.fromJson(json['datetime'])
        : null;
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    status = json['status'];
    user = json['user'];
    imgurl = json['imgurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datetime != null) {
      data['datetime'] = this.datetime!.toJson();
    }
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['user'] = this.user;
    data['imgurl'] = this.imgurl;
    return data;
  }
}

class Datetime {
  int? seconds;
  int? nanoseconds;

  Datetime({this.seconds, this.nanoseconds});

  Datetime.fromJson(Map<String, dynamic> json) {
    seconds = json['seconds'];
    nanoseconds = json['nanoseconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seconds'] = this.seconds;
    data['nanoseconds'] = this.nanoseconds;
    return data;
  }
}
