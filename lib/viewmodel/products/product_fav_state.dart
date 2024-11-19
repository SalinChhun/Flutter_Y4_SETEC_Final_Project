part of 'product_fav_bloc.dart';

@immutable
abstract class ProductFavState {}

class ProductFavInitial extends ProductFavState {


}
class ProductfavLoading extends ProductFavState {

}
class ProductFavSuccess  extends ProductFavState {

}
class ProductfavDone extends ProductFavState {
  ProductFavModel productFavModel;

  ProductfavDone(this.productFavModel);
}
class ProductfavError extends ProductFavState {
var msg;

ProductfavError( { this.msg });
}

class ProductByIdSuccess extends ProductFavState {
  ProductFavModel productFavModel;

  ProductByIdSuccess(this.productFavModel);
  }
class ProductByIdError  extends ProductFavState {

}
class ProductByIdLoading extends ProductFavState {

}