part of 'cart_bloc.dart';


abstract class CartEvent {}

class CartToAdd extends CartEvent{
  CartItem? cartitem;


  CartToAdd({this.cartitem});


}


class CartToLoaded extends CartEvent{



}
class CartClear extends CartEvent{



  CartClear();


}
class CartRemoveAll extends CartEvent{
  CartItem? cartitem;


  CartRemoveAll({this.cartitem});


}
class CartToRemove extends CartEvent{
  CartItem? cartitem;


  CartToRemove({this.cartitem});
}
class CartToUpdate extends CartEvent{

}