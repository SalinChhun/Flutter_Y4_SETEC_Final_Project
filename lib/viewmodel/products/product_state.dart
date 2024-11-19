part of 'product_bloc.dart';


abstract class ProductState extends Equatable{

}
class ProductInitialSearch extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}

class ProductClear extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ProductInitial extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ProductCompleted extends ProductState {
 ProductModel? product;


  ProductCompleted({this.product});

  @override
  // TODO: implement props
  List<Object?> get props => [product];

}

class ProductSortCompleted extends ProductState {
  ProductModel? product;


  ProductSortCompleted({this.product});

  @override
  // TODO: implement props
  List<Object?> get props => [product];

}
class ProductSortLoading extends ProductState {



  ProductSortLoading();

  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ProductSortError extends ProductState {



  ProductSortError();

  @override
  // TODO: implement props
  List<Object?> get props => [];

}


class ProductSerachCompleted extends ProductState {
  ProductModel? product;


  ProductSerachCompleted({this.product});

  @override
  // TODO: implement props
  List<Object?> get props => [product];

}
class ProductDiscountCompleted extends ProductState {
  ProductModel? product;


  ProductDiscountCompleted({this.product});

  @override
  // TODO: implement props
  List<Object?> get props => [product];

}
class ProductLoading extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ProductSearchLoading extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ProductSearchError extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ProductError extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ProductLoadingDiscount extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}

class ProductErrorDiscount extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
