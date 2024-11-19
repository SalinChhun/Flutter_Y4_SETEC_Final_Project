import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/viewmodel/products/product_bloc.dart';
import 'package:meta/meta.dart';

import '../../model/Product/ProductModel.dart';
import '../../repository/Product/ProductRepository.dart';

part 'product_search_review_event.dart';
part 'product_search_review_state.dart';

class ProductSearchReviewBloc extends Bloc<ProductSearchReviewEvent, ProductSearchReviewState> {
  ProductRepository productRepository = ProductRepository();
  ProductSearchReviewBloc() : super(ProductSearchReviewInitial()) {
    on<ProductPreview>((event, emit)  async {
      // TODO: implement event handler
      emit(PreviewLoading());
      try{

        print("Search even is ${event.title}");
        if(event.title == null) {
          event.title = "";
        }

        var response = await productRepository.SortProduct(event.sortname,event.rank,search: event.title,page: event.page );


        print("Product Sorting Event Send to");
        // print(response);
        emit(PreviewCompleted(product: response));




      }catch(error) {
        print(error.toString());
        emit((PreviewError()));
      }
    });
  }
}
