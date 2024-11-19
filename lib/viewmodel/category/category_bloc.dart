import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../model/Category/CategoryModel.dart';
import '../../model/Category/ProductCategory.dart';
import '../../repository/Category/CategoryRepository.dart';
part 'category_event.dart';
part 'category_state.dart';
CategoryRepository categoryRepository =   CategoryRepository();
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  CategoryBloc() : super(CategoryInitial()) {
    on<FetchCategory>((event, emit) => CategoryEventEmit(event,emit));
    on<FetchCategoryProduct>((event, emit) => CategoryEventByIdEmit(event,emit));
  }

  CategoryEventEmit(FetchCategory event, Emitter<CategoryState> emit) async{
    emit(CategoryLoading());
    try{
      var response = await  categoryRepository .FetchCategory();
      print("Category even  bloc here");
      print(response);


      emit(CategoryCompleted(category:response ));

    }catch(error) {
      print(error.toString());
      emit(CategoryError());
    }

  }


  CategoryEventByIdEmit(FetchCategoryProduct event, Emitter<CategoryState> emit) async{
    emit(CategoryByidLoading());
    try{
      var response = await  categoryRepository .FetchCategoryProduct(event.categoryid);
      print("Category event product  bloc here");
      print(response);


      emit(CategoryByidCompleted(product:response ));

    }catch(error) {
      print(error.toString());
      emit(CategoryByidError());
    }

  }
}

class CategoryBlocProduct extends Bloc<CategoryEvent, CategoryState> {

  CategoryBlocProduct() : super(CategoryInitial()) {

    on<FetchCategoryProduct>((event, emit) => CategoryEventByIdEmit(event,emit));
  }

  CategoryEventEmit(FetchCategory event, Emitter<CategoryState> emit) async{
    emit(CategoryLoading());
    try{
      var response = await  categoryRepository .FetchCategory();
      print("Category even  bloc here");
      print(response);


      emit(CategoryCompleted(category:response ));

    }catch(error) {
      print(error.toString());
      emit(CategoryError());
    }

  }


  CategoryEventByIdEmit(FetchCategoryProduct event, Emitter<CategoryState> emit) async{
    emit(CategoryByidLoading());
    try{
      var response = await  categoryRepository .FetchCategoryProduct(event.categoryid);
      print("Category event product  bloc here");
      print(response);


      emit(CategoryByidCompleted(product:response ));

    }catch(error) {
      print(error.toString());
      emit(CategoryByidError());
    }

  }
}
