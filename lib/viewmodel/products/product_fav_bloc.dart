import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/network/networkservice.dart';
import '../../model/Product/ProductFavModel.dart';
import '../../repository/Product/ProductRepository.dart';

part 'product_fav_event.dart';
part 'product_fav_state.dart';

class ProductFavBloc extends Bloc<ProductFavEvent, ProductFavState> {
  NetworkApiService product =NetworkApiService();
  ProductRepository productRepository = ProductRepository();
  ProductFavBloc() : super(ProductFavInitial()) {
    on<ShowFavorite>((event, emit) async {
      // TODO: implement event handler
      emit(ProductfavLoading());
      try{
        var response = await productRepository.FavFetchProduct(event.userid);
        print(response);
        emit(ProductfavDone(response));
      }catch(error) {
        emit(ProductfavError(msg: error.toString()));
      }
    });
    on<AddFavorite>((event, emit) async {
      // TODO: implement event handler
      emit(ProductfavLoading());
      try{
        var response = await product.AddFavorite(event.pid, event.userid);
        print(response);
        emit(ProductFavSuccess());
      }catch(error) {
        emit(ProductfavError(msg: error.toString()));
      }


    });
    on<ProductById>((event, emit) async {
      // TODO: implement event handler
      emit(ProductByIdLoading());
      try{
        var response =  await productRepository.ProductFavoriteById(event.userid, event.pid);
        // print(response);
        emit(ProductByIdSuccess(response));
      }catch(error) {
        print(error.toString());
        emit(ProductByIdError());
      }


    });
    on<RemoveFavorite>((event, emit) async {
      // TODO: implement event handler
      emit(ProductfavLoading());
      try{
        var response = await productRepository.RemoveFavorite(event.pid,event.userid);
        print(response);
        emit(ProductFavSuccess());
      }catch(error) {
        emit(ProductfavError(msg: error.toString()));
      }


    });
  }

}
