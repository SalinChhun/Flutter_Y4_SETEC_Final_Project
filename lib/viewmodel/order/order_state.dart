part of 'order_bloc.dart';


abstract class OrderState {}

class OrderInitial extends OrderState {

}
class OrderLoading extends OrderState {

}
class OrderStripePending extends OrderState {

}
class OrderSuccessError extends OrderState {

}

class OrderSuccessCompleted extends OrderState {
  OrderReponse? orderReponse;
  var orderid;


  OrderSuccessCompleted({this.orderReponse}){
    print(this.orderReponse);
  }
}
class OrderError extends OrderState {

}

class OrderSuccess extends OrderState {
  OrderReponse? orderReponse;

  OrderSuccess(this.orderReponse);
}
class OrderDetailLoading extends OrderState{

}
class OrderDetailError extends OrderState{

}
class OrderDetailSuccess extends OrderState{
OrderList? orderDetail;

OrderDetailSuccess(this.orderDetail);
}

class OrderUserLoading extends OrderState {

}
class OrderUserComplete extends OrderState {
  OrderListUser? orderDetail;

  OrderUserComplete(this.orderDetail);
}
class OrderUserError extends OrderState {


  OrderUserError( );
}
