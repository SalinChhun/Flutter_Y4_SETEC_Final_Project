class SuperDealModel {
  int? pagePerQuery;
  int? pageSize;
  int? totalPages;
  int? currentPageNumber;
  List<Results>? results;

  SuperDealModel(
      {this.pagePerQuery,
        this.pageSize,
        this.totalPages,
        this.currentPageNumber,
        this.results});

  SuperDealModel.fromJson(Map<String, dynamic> json) {
    pagePerQuery = json['page_per_query'];
    pageSize = json['page_size'];
    totalPages = json['total_pages'];
    currentPageNumber = json['current_page_number'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_per_query'] = this.pagePerQuery;
    data['page_size'] = this.pageSize;
    data['total_pages'] = this.totalPages;
    data['current_page_number'] = this.currentPageNumber;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  List<Product>? product;
  Imgid? imgid;
  String? dealname;
  String? description;
  String? discount;

  Results(
      {this.id,
        this.product,
        this.imgid,
        this.dealname,
        this.description,
        this.discount});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
    imgid = json['imgid'] != null ? new Imgid.fromJson(json['imgid']) : null;
    dealname = json['dealname'];
    description = json['description'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    if (this.imgid != null) {
      data['imgid'] = this.imgid!.toJson();
    }
    data['dealname'] = this.dealname;
    data['description'] = this.description;
    data['discount'] = this.discount;
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
  String? unit;
  String? brand;
  String? model;
  String? materialName;

  Attribution(
      {this.id,
        this.colorid,
        this.size,
        this.weight,
        this.unit,
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
    unit = json['unit'];
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
    data['unit'] = this.unit;
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
  String? code;
  double? price;
  int? stockqty;
  String? desc;

  Colorid(
      {this.id,
        this.imgid,
        this.color,
        this.code,
        this.price,
        this.stockqty,
        this.desc});

  Colorid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgid = json['imgid'] != null ? new Imgid.fromJson(json['imgid']) : null;
    color = json['color'];
    code = json['code'];
    price = json['price'];
    stockqty = json['stockqty'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.imgid != null) {
      data['imgid'] = this.imgid!.toJson();
    }
    data['color'] = this.color;
    data['code'] = this.code;
    data['price'] = this.price;
    data['stockqty'] = this.stockqty;
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
