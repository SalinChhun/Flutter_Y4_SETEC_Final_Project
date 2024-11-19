import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/model/Order/OrderRequest.dart';
import 'package:ecommerce/model/Order/OrderResponse.dart';
import 'package:meta/meta.dart';

import '../../model/Order/OrderDetail.dart';
import '../../model/Order/OrderReq.dart';
import 'package:equatable/equatable.dart';

import '../../model/Order/OrderUser.dart';
import '../../repository/Order/OrderRepository.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderRepository orderRepository = OrderRepository();
  OrderBloc() : super(OrderInitial()) {
    on<PostOrderEvent>((event, emit) async {
      // TODO: implement event handler

      emit(OrderLoading());

      try{
        print("Event Order Send");
        print(event.addressid);
            var res = await orderRepository.PostOrderUser(event.addressid,event.orderRequestV2);
            // print(res.toString());
            print(res);
            emit(OrderSuccessCompleted(orderReponse: res));
            print("state change");
            // emit(OrderSuccess(res));

      }catch(error) {
        print(error);
        emit(OrderError());
      }
    });
    on<GetOrderDetail>((event, emit) async {
      // TODO: implement event handler

      emit(OrderDetailLoading());

      try{
        print("Event Order Detail Summar");
        var res = await orderRepository.GetOrderSummary(event.orderid);
        print("response");
        print(res);
        emit(OrderDetailSuccess(res));
      }catch(error) {
        emit(OrderDetailError());
      }
    });
    on<GetUserorder>((event, emit) async {
      // TODO: implement event handler

      emit(OrderUserLoading());

      try{
        print("Event User Order Sent");
        var res = await orderRepository.GetOrderUser(event.userid);
        emit(OrderUserComplete(res));
      }catch(error) {
        emit(OrderUserError());
      }
    });
    on<OrderStripe>((event, emit) {
      // TODO: implement event handler
      emit(OrderStripePending());






    });
  }
}

class OrderBlocUser extends Bloc<OrderEvent, OrderState> {
  OrderRepository orderRepository = OrderRepository();
  OrderBlocUser() : super(OrderInitial()) {

    on<GetOrderDetail>((event, emit) async {
      // TODO: implement event handler

      emit(OrderDetailLoading());

      try{
        print("Event Order Detail Summar");
        var res = await orderRepository.GetOrderSummary(event.orderid);
        print("response");
        print(res);
        emit(OrderDetailSuccess(res));
      }catch(error) {
        emit(OrderDetailError());
      }
    });
    on<PostOrderEvent>((event, emit) async {
      // TODO: implement event handler

      emit(OrderLoading());

      try{
        print("Event Order Send");
        print(event.addressid);
        var res = await orderRepository.PostOrderUser(event.addressid,event.orderRequestV2);
        // print(res.toString());
        print(res);
        emit(OrderSuccessCompleted(orderReponse: res));
        print("state change");
        // emit(OrderSuccess(res));

      }catch(error) {
        print(error);
        emit(OrderError());
      }
    });
  }

}
