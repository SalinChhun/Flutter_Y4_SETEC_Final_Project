part of 'order_bloc.dart';


abstract class OrderEvent {}

class PostOrderEvent extends OrderEvent{
  OrderRequestV2? orderRequestV2;
  var addressid;

  PostOrderEvent({this.orderRequestV2,this.addressid});
}

class GetOrderDetail extends OrderEvent{
var orderid;


  GetOrderDetail({this.orderid});
}

class GetUserorder extends OrderEvent {
    var userid;

    GetUserorder({this.userid});
}
class OrderStripe extends OrderEvent {

}