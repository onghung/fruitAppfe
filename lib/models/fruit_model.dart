class Fruit {
  String? baoquan;
  String? discription;
  int? id;
  String? name;
  int? price;
  String? organic;
  double? start;
  String? imgurl;

  Fruit(
      {this.baoquan,
        this.discription,
        this.id,
        this.name,
        this.price,
        this.organic,
        this.start,
        this.imgurl});

  Fruit.fromJson(Map<String, dynamic> json) {
    baoquan = json['baoquan'];
    discription = json['discription'];
    id = json['id'];
    name = json['name'];
    price = json['price'];
    organic = json['organic'];
    start = json['start'];
    imgurl = json['imgurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['baoquan'] = this.baoquan;
    data['discription'] = this.discription;
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['organic'] = this.organic;
    data['start'] = this.start;
    data['imgurl'] = this.imgurl;
    return data;
  }
}
