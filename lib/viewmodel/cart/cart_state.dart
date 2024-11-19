part of 'cart_bloc.dart';




// class AllCart {
//
//   List<CartItem>? itemcart =[];
//
//
//   AllCart({this.itemcart});
//
//
//
//
//   void InsertToCart(CartItem item){
//     itemcart!.add(item);
//
//   }
//
//   void removeFromCart(CartItem item){
//     itemcart!.removeWhere((element) => element == item);
//   }
// }

class AllCart {
  List<CartItem>? itemcart;

  AllCart({this.itemcart});






  void InsertToCart(CartItem item){
    itemcart!.add(item);

  }

  void removeFromCart(CartItem item){
    itemcart!.removeWhere((element) => element == item);
  }
}
class InitState extends AllCart {
  InitState():super(itemcart: []);
}
