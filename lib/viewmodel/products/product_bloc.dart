import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/repository/Product/ProductRepository.dart';
import 'package:ecommerce/views/client/product/SuperDeal.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../model/Product/ProductModel.dart';
part 'product_event.dart';

part 'product_state.dart';
ProductRepository productRepository = ProductRepository();
class ProductBloc extends Bloc<ProductEvent, ProductState> {

  ProductBloc() : super(ProductInitial()) {

    on<FetchProduct>((event, emit) => FetchingProduct(event,emit) ,);
    on<SortProduct>((event, emit) => SortingProduct(event,emit) ,);
    on<ClearAllState>((event, emit) => ClearProduct(event,emit) ,);

  }

  ClearProduct(ClearAllState event, Emitter<ProductState> emit) async {
    ProductCompleted().product?.results?.clear();
    emit(ProductInitial());
    emit(ProductLoading());



  }


}





class ProductBlocSorting extends Bloc<ProductEvent, ProductState> {

  ProductBlocSorting() : super(ProductInitial()) {

    on<SortProduct>((event, emit) => SortingProductV2(event,emit) ,);
    on<SortProductSearch>((event, emit) => SortingProductSearchV2(event,emit) ,);
    on<DiscountProduct>((event, emit) => DiscountProductSort(event,emit) ,);
    on<ProductFilter>((event, emit) => ProductFilering(event,emit) ,);
    on<ClearProductSorting>((event, emit) {

      emit(ProductClear());





    },);
  }

  SortingProductV2(SortProduct event, Emitter<ProductState> emit) async {
    emit(ProductSortLoading());
    try{

  print("Search even is ${event.title}");
  if(event.title == null) {
    event.title = "";
  }

      var response = await productRepository.SortProduct(event.sortname,event.rank,search: event.title,page: event.page );


      print("Product Sorting Event Send to");
      // print(response);


      emit((ProductSortCompleted(product:response)));

      }catch(error) {
        print(error.toString());
        emit((ProductSortError()));
      }


  }

  DiscountProductSort(DiscountProduct event, Emitter<ProductState> emit) async {
    emit(ProductSortLoading());
    try{
      var response = await productRepository.FetchProductDiscount( );
      print("Discount event sent");
      // print(response);


      emit( ProductSortCompleted(product:response));

    }catch(error) {
      print(error.toString());
      emit(ProductSortError());
    }
  }

  SortingProductSearchV2(SortProductSearch event, Emitter<ProductState> emit) async {
    emit(ProductSortLoading());
    try{
      var response = await productRepository.QueryProduct(event.title,page: event.page);
      print("Product query event send");
      // print(response);


      emit(ProductSortCompleted(product:response));

    }catch(error) {
      print(error.toString());
      emit(ProductSortError());
    }

  }

  ProductFilering(ProductFilter event, Emitter<ProductState> emit) async {
    emit(ProductSortLoading());
    try{

      print("Search Filter even is ${event.search}");


      var response = await productRepository.QueryProductFilter(
        event.search,

        minprice: event.min,
        maxprice: event.max,
        cid: event.category,
        sort: event.sortby,
        rank: event.rank

      );


      print("Product Filter Event Send to");
      // print(response);


      emit((ProductSortCompleted(product:response)));

    }catch(error) {
      print(error.toString());
      emit((ProductSortError()));
    }


  }








}


class ProductBlocBestSell extends Bloc<ProductEvent, ProductState> {

  ProductBlocBestSell() : super(ProductInitial()) {

    on<SortProduct>((event, emit) => SortingProduct(event,emit) ,);


  }





}

class ProductBlocBestRating extends Bloc<ProductEvent, ProductState> {

  ProductBlocBestRating() : super(ProductInitial()) {

    on<SortProduct>((event, emit) => SortingProduct(event,emit) ,);


  }






}

class ProductBlocBestPrice extends Bloc<ProductEvent, ProductState> {

  ProductBlocBestPrice() : super(ProductInitial()) {
    on<FetchProduct>((event, emit) => FetchingProduct(event,emit) ,);
    on<SortProduct>((event, emit) => SortingProduct(event,emit) ,);


  }

  SortingProductV2(SortProduct event, Emitter<ProductState> emit) async {

    emit(ProductLoading());
    try{
      var response = await productRepository.FetchProduct();
      print("Product sort bloc here");
      print(response);


      emit(ProductCompleted(product:response));

    }catch(error) {
      print(error.toString());
      emit(ProductSearchError());
    }


  }

  FetchingProduct(FetchProduct event, Emitter<ProductState> emit) async {


    // TODO: implement event handler
    emit(ProductLoading());

    try{
      var response = await productRepository.FetchProduct();
      print("Product bloc here");
      print(response);


      emit(ProductCompleted(product:response));

    }catch(error) {
      print(error.toString());
      emit(ProductError());
    }



  }

  SortingProduct(SortProduct event, Emitter<ProductState> emit) async {

    emit(ProductLoading());
    try{
      var response = await productRepository.FetchProduct();
      print("Product sort bloc here");
      print(response);


      emit(ProductCompleted(product:response));

    }catch(error) {
      print(error.toString());
      emit(ProductSearchError());
    }


  }

  QueryProductSearch(QueryProduct event, Emitter<ProductState> emit) async {
    emit(ProductSearchLoading());
    try{
      var response = await productRepository.QueryProduct(event.search);
      print("Product query event send");
      print(response);


      emit(ProductSerachCompleted(product:response));

    }catch(error) {
      print(error.toString());
      emit(ProductSearchError());
    }
  }


}
class ProductSearchBloc extends Bloc<ProductEvent, ProductState> {

  ProductSearchBloc() : super(ProductInitialSearch()) {

    on<QueryProduct>((event, emit) => QueryProductSearch(event,emit) ,);

  }

  FetchingProduct(FetchProduct event, Emitter<ProductState> emit) async {


    // TODO: implement event handler
    emit(ProductLoading());

    try{
      var response = await productRepository.FetchProduct();
      print("Product bloc here");
      // print(response);


      emit(ProductCompleted(product:response));

    }catch(error) {
      print(error.toString());
      emit(ProductError());
    }



  }

  SortingProduct(SortProduct event, Emitter<ProductState> emit) async {

    emit(ProductLoading());
    try{
      var response = await productRepository.FetchProduct();
      print("Product sort bloc here");
      // print(response);


      emit(ProductCompleted(product:response));

    }catch(error) {
      print(error.toString());
      emit(ProductSearchError());
    }


  }

  QueryProductSearch(QueryProduct event, Emitter<ProductState> emit) async {

    emit(ProductSearchLoading());
    try{
      var response = await productRepository.QueryProduct(event.search);
      print("Product query event send");
      // print(response);


      emit(ProductSerachCompleted(product:response));

    }catch(error) {
      print(error.toString());
      emit(ProductSearchError());
    }
  }


}

class ProductDiscountBloc extends Bloc<ProductEvent, ProductState> {
  ProductDiscountBloc() : super(ProductInitial()) {

    on<DiscountProduct>((event, emit) =>Discount(event,emit) ,);
  }
  Discount(DiscountProduct event, Emitter<ProductState> emit) async {

    emit(ProductLoadingDiscount());
    try{
      var response = await productRepository.FetchProductDiscount( );
      print("Discount event sent");
      print(response);


      emit( ProductDiscountCompleted(product:response));

    }catch(error) {
      print(error.toString());
      emit(ProductErrorDiscount());
    }

  }
}






FetchingProduct(FetchProduct event, Emitter<ProductState> emit) async {


  // TODO: implement event handler
  emit(ProductLoading());
  print(event.page);

  try{

    var response = await productRepository.FetchProduct(page: event.page);
    print("Product bloc here");
    // print(response);


    emit(ProductCompleted(product:response));

  }catch(error) {
    print(error.toString());
    emit(ProductError());
  }



}

SortingProduct(SortProduct event, Emitter<ProductState> emit) async {

  emit(ProductLoading());
  try{
    var response = await productRepository.SortProduct(event.sortname,event.rank);
    print("Product sort bloc send here");
    //print(response);


    emit(ProductCompleted(product:response));

  }catch(error) {
    print(error.toString());
    emit(ProductError());
  }


}



QueryProductSearch(QueryProduct event, Emitter<ProductState> emit) async {
  emit(ProductSearchLoading());
  try{
    var response = await productRepository.QueryProduct(event.search);
    //print("Product query event send");
    //print(response);


    emit(ProductSerachCompleted(product:response));

  }catch(error) {
    print(error.toString());
    emit(ProductSearchError());
  }
}