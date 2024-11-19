class OrderRequestV2 {
  String? method;
  List<Productss>? productss;
  int? customer;

  OrderRequestV2({this.method, this.productss, this.customer});

  OrderRequestV2.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    if (json['productss'] != null) {
      productss = <Productss>[];
      json['productss'].forEach((v) {
        productss!.add(new Productss.fromJson(v));
      });
    }
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    if (this.productss != null) {
      data['productss'] = this.productss!.map((v) => v.toJson()).toList();
    }
    data['customer'] = this.customer;
    return data;
  }
}

class Productss {
  int? id;
  int? quantity;
  int? colorselection;
  int? size;

  Productss({this.id, this.quantity, this.colorselection, this.size});

  Productss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    colorselection = json['colorselection'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['colorselection'] = this.colorselection;
    data['size'] = this.size;
    return data;
  }
}
