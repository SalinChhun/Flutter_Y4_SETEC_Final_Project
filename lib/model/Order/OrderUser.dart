class OrderListUser {
  int? count;
  Null? next;
  Null? previous;
  List<Results>? results;

  OrderListUser({this.count, this.next, this.previous, this.results});

  OrderListUser.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  Address? address;
  List<Products>? products;
  bool? delivered;
  String? shippedAt;
  String? updatedDate;
  String? method;
  String? amount;
  bool? ispaid;
  String? status;
  int? customer;

  Results(
      {this.id,
        this.address,
        this.products,
        this.delivered,
        this.shippedAt,
        this.updatedDate,
        this.method,
        this.amount,
        this.ispaid,
        this.status,
        this.customer});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    delivered = json['delivered'];
    shippedAt = json['shipped_at'];
    updatedDate = json['updated_date'];
    method = json['method'];
    amount = json['amount'];
    ispaid = json['ispaid'];
    status = json['status'];
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['delivered'] = this.delivered;
    data['shipped_at'] = this.shippedAt;
    data['updated_date'] = this.updatedDate;
    data['method'] = this.method;
    data['amount'] = this.amount;
    data['ispaid'] = this.ispaid;
    data['status'] = this.status;
    data['customer'] = this.customer;
    return data;
  }
}

class Address {
  int? id;
  CustomerId? customerId;
  String? street;
  String? city;
  String? latitude;
  String? longitude;
  String? description;
  String? country;

  Address(
      {this.id,
        this.customerId,
        this.street,
        this.city,
        this.latitude,
        this.longitude,
        this.description,
        this.country});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'] != null
        ? new CustomerId.fromJson(json['customer_id'])
        : null;
    street = json['street'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    description = json['description'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.customerId != null) {
      data['customer_id'] = this.customerId!.toJson();
    }
    data['street'] = this.street;
    data['city'] = this.city;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['description'] = this.description;
    data['country'] = this.country;
    return data;
  }
}

class CustomerId {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? telephone;
  String? gender;
  Imgid? imgid;
  String? password;
  String? username;

  CustomerId(
      {this.id,
        this.firstname,
        this.lastname,
        this.email,
        this.telephone,
        this.gender,
        this.imgid,
        this.password,
        this.username});

  CustomerId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    telephone = json['telephone'];
    gender = json['gender'];
    imgid = json['imgid'] != null ? new Imgid.fromJson(json['imgid']) : null;
    password = json['password'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['gender'] = this.gender;
    if (this.imgid != null) {
      data['imgid'] = this.imgid!.toJson();
    }
    data['password'] = this.password;
    data['username'] = this.username;
    return data;
  }
}

class Imgid {
  int? id;
  String? images;

  Imgid({this.id, this.images});

  Imgid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['images'] = this.images;
    return data;
  }
}

class Products {
  Product? product;
  int? quantity;
  Colorid? colorselection;
  Null? imageproduct;
  Size? size;

  Products(
      {this.product,
        this.quantity,
        this.colorselection,
        this.imageproduct,
        this.size});

  Products.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    colorselection = json['colorselection'] != null
        ? new Colorid.fromJson(json['colorselection'])
        : null;
    imageproduct = json['imageproduct'];
    size = json['size'] != null ? new Size.fromJson(json['size']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    if (this.colorselection != null) {
      data['colorselection'] = this.colorselection!.toJson();
    }
    data['imageproduct'] = this.imageproduct;
    if (this.size != null) {
      data['size'] = this.size!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  Category? category;
  Owner? owner;
  List<Imgid>? imgid;
  Attribution? attribution;
  String? productname;
  double? price;
  int? stockqty;
  double? avgRating;
  int? discount;
  int? sellRating;
  String? description;

  Product(
      {this.id,
        this.category,
        this.owner,
        this.imgid,
        this.attribution,
        this.productname,
        this.price,
        this.stockqty,
        this.avgRating,
        this.discount,
        this.sellRating,
        this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    if (json['imgid'] != null) {
      imgid = <Imgid>[];
      json['imgid'].forEach((v) {
        imgid!.add(new Imgid.fromJson(v));
      });
    }
    attribution = json['attribution'] != null
        ? new Attribution.fromJson(json['attribution'])
        : null;
    productname = json['productname'];
    price = json['price'];
    stockqty = json['stockqty'];
    avgRating = json['avg_rating'];
    discount = json['discount'];
    sellRating = json['sell_rating'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    if (this.imgid != null) {
      data['imgid'] = this.imgid!.map((v) => v.toJson()).toList();
    }
    if (this.attribution != null) {
      data['attribution'] = this.attribution!.toJson();
    }
    data['productname'] = this.productname;
    data['price'] = this.price;
    data['stockqty'] = this.stockqty;
    data['avg_rating'] = this.avgRating;
    data['discount'] = this.discount;
    data['sell_rating'] = this.sellRating;
    data['description'] = this.description;
    return data;
  }
}

class Category {
  int? id;
  String? categoryname;
  Imgid? imgid;

  Category({this.id, this.categoryname, this.imgid});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryname = json['categoryname'];
    imgid = json['imgid'] != null ? new Imgid.fromJson(json['imgid']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryname'] = this.categoryname;
    if (this.imgid != null) {
      data['imgid'] = this.imgid!.toJson();
    }
    return data;
  }
}

class Owner {
  String? username;
  String? email;

  Owner({this.username, this.email});

  Owner.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    return data;
  }
}

class Attribution {
  int? id;
  List<Colorid>? colorid;
  List<Size>? size;
  double? weight;
  String? brand;
  String? model;
  String? materialName;

  Attribution(
      {this.id,
        this.colorid,
        this.size,
        this.weight,
        this.brand,
        this.model,
        this.materialName});

  Attribution.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['colorid'] != null) {
      colorid = <Colorid>[];
      json['colorid'].forEach((v) {
        colorid!.add(new Colorid.fromJson(v));
      });
    }
    if (json['size'] != null) {
      size = <Size>[];
      json['size'].forEach((v) {
        size!.add(new Size.fromJson(v));
      });
    }
    weight = json['weight'];
    brand = json['brand'];
    model = json['model'];
    materialName = json['material_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.colorid != null) {
      data['colorid'] = this.colorid!.map((v) => v.toJson()).toList();
    }
    if (this.size != null) {
      data['size'] = this.size!.map((v) => v.toJson()).toList();
    }
    data['weight'] = this.weight;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['material_name'] = this.materialName;
    return data;
  }
}

class Colorid {
  int? id;
  Imgid? imgid;
  String? color;
  String? desc;

  Colorid({this.id, this.imgid, this.color, this.desc});

  Colorid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgid = json['imgid'] != null ? new Imgid.fromJson(json['imgid']) : null;
    color = json['color'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.imgid != null) {
      data['imgid'] = this.imgid!.toJson();
    }
    data['color'] = this.color;
    data['desc'] = this.desc;
    return data;
  }
}

class Size {
  int? id;
  String? size;

  Size({this.id, this.size});

  Size.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    return data;
  }
}
