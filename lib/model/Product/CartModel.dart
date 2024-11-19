import 'dart:convert';

import 'package:ecommerce/model/Category/ProductCategory.dart';
import 'package:ecommerce/model/Product/ProductModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CartItem{
  var productid;
  int? qty;
  var cartid;
  var producttitle;
  var imgurl;
  var price;
  var sizetext;
 var attribution;
 var colorcode;
 var stockqty;

  var discount;
  var colorid;
  var imgid;
  var sizeid;

  CartItem({this.productid, this.qty, this.producttitle, this.imgurl, this.price,
    this.colorcode,
    this.stockqty,
    this.cartid,

      this.attribution, this.discount,this.colorid,this.imgid,this.sizeid,this.sizetext });


  // Convert CartItem to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'productid': productid,
      'qty': qty,
      'producttitle': producttitle,
      'imgurl': imgurl,
      'price': price,
      'colorcode': colorcode,
      'stockqty': stockqty,
      'cartid': cartid,
      'attribution': attribution,
      'discount': discount,
      'colorid': colorid,
      'imgid': imgid,
      'sizeid': sizeid,
      'sizetext': sizetext,
    };
  }

  // Create CartItem from a JSON map
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productid: json['productid'],
      qty: json['qty'],
      producttitle: json['producttitle'],
      imgurl: json['imgurl'],
      price: json['price'],
      colorcode: json['colorcode'],
      stockqty: json['stockqty'],
      cartid: json['cartid'],
      attribution: json['attribution'],
      discount: json['discount'],
      colorid: json['colorid'],
      imgid: json['imgid'],
      sizeid: json['sizeid'],
      sizetext: json['sizetext'],
    );
  }
}

class CartModel {
  List<CartItem> _item = [];

  List<CartItem> get item => _item;


}