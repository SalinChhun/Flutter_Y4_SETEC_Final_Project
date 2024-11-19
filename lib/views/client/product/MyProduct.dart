class MyProductDetail {
  int? id;
  var categoryid;
  var imgid;
 var attribution;
  String? productname;
  double? price;
  int? stockqty;
  double? avgRating;
  int? discount;
  int? sellRating;

  String? description;
  MyProductDetail(
      {this.id,
        this.categoryid,

        this.imgid,
        this.attribution,
        this.productname,
        this.price,
        this.stockqty,
        this.avgRating,
        this.discount,
        this.sellRating,
        this.description});
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


}
class Imgid {
  int? id;
  String? images;

  Imgid({this.id, this.images});


}
class Colorid {
  int? id;
  Imgid? imgid;
  String? color;
  String? desc;

  Colorid({this.id, this.imgid, this.color, this.desc});

}

class Size {
  int? id;
  String? size;

  Size({this.id, this.size});


}

class Category {
  int? id;
  String? categoryname;
  Imgid? imgid;

}