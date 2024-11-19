part of 'product_search_review_bloc.dart';


abstract class ProductSearchReviewState {

}

class ProductSearchReviewInitial extends ProductSearchReviewState {

}
class PreviewLoading extends ProductSearchReviewState {

}
class PreviewError extends ProductSearchReviewState {

}
class PreviewCompleted extends ProductSearchReviewState {


  ProductModel? product;


  PreviewCompleted({this.product});



}
