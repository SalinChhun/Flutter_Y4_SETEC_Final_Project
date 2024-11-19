part of 'product_bloc.dart';


abstract class ProductEvent
{}

class ClearProductSorting extends ProductEvent {


  ClearProductSorting();
}
class FetchProduct extends ProductEvent {

  var page;

  FetchProduct( {this.page });
}
class ClearAllState extends ProductEvent {

}
class ProductFilter extends ProductEvent {
  var search;
  var min;
  var max;
  var category;
  var sortby;
  var rank;
  var page;

  ProductFilter( {this.min, this.max, this.category, this.sortby,this.search,this.rank,this.page});
}

class SortProduct extends ProductEvent {
var sortname ;
var page;
var rank;
var title;

SortProduct( {this.sortname, this.rank ,this.title,this.page});
}

class SortProductSearch extends ProductEvent {
  var sortname ;
  var rank;
  var title;
  var page;

  SortProductSearch( {this.sortname, this.rank ,this.title,this.page});
}
class DiscountProduct extends ProductEvent {
  var page;

  DiscountProduct({this.page}) ;
}

class PutProduct extends ProductEvent {

}

class GetProduct extends ProductEvent {

}

class DeleteProduct extends ProductEvent {

}

class QueryProduct extends ProductEvent {
  var search;

  QueryProduct(this.search);
}