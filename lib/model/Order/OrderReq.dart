class OrderRequest {
  String? method;
  List<Products>? products;
  int? customer;

  OrderRequest({this.method, this.products, this.customer});

  OrderRequest.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['customer'] = this.customer;
    return data;
  }
}

class Products {
  int? id;
  int? quantity;
  int? colorselection;
  int? imageproduct;

  Products({this.id, this.quantity, this.colorselection, this.imageproduct});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    colorselection = json['colorselection'];
    imageproduct = json['imageproduct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['colorselection'] = this.colorselection;
    data['imageproduct'] = this.imageproduct;
    return data;
  }
}
