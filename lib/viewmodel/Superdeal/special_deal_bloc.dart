import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/model/Product/SuperdealModel.dart';
import 'package:meta/meta.dart';

import '../../model/Product/SuperDealById.dart';
import '../../repository/Product/ProductRepository.dart';
import '../products/product_bloc.dart';

part 'special_deal_event.dart';
part 'special_deal_state.dart';

class SpecialDealBloc extends Bloc<SpecialDealEvent, SpecialDealState> {

  ProductRepository productRepository = ProductRepository();

  SpecialDealBloc() : super(SpecialDealInitial()) {
    on<FetchDeal>((event, emit) async {
      // TODO: implement event handler
      emit(SepcialDealLoading());


      try {
        emit(SepcialDealLoading());
        var res = await productRepository.FetchSuperDeal();
        emit(SepcialDealCompleted(res));
        // print(response);


      } catch (error) {
        emit(SpecialDealError(error.toString()));
        print(error.toString());
      }
    });
    on<FetchById>((event, emit) async {
      // TODO: implement event handler


      try {
        emit(SepcialDealByIdLoading());
        var res = await productRepository.FetchSuperSingle(event.id);
        emit(SepcialDealByIdCompleted(res));
        // print(response);


      } catch (error) {
        emit(SepcialDealByIdError());
        print(error.toString());
      }
    });
    on<ClearState>((event, emit) async {

      print("Event clear send");
      // TODO: implement event handler
      emit(ResetState());
    });
  }
}
