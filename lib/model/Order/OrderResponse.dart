class OrderReponse {
  Data? data;
  int? id;

  OrderReponse({this.data, this.id});

  OrderReponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Data {
  String? method;
  int? customer;

  Data({this.method, this.customer});

  Data.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    data['customer'] = this.customer;
    return data;
  }
}
