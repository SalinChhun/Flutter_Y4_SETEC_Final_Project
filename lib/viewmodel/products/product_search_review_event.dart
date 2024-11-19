part of 'product_search_review_bloc.dart';


abstract class ProductSearchReviewEvent {


}
class ProductPreview extends ProductSearchReviewEvent {
  var sortname ;
  var page;
  var rank;
  var title;

  ProductPreview( {this.sortname, this.rank ,this.title,this.page});
}