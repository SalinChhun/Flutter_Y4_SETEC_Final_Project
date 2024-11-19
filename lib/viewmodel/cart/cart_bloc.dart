import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../model/Product/CartModel.dart';
import '../../model/Product/ProductModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, AllCart> {
  // CartModel cartModel = CartModel();
  CartBloc() : super(InitState()) {


    on<CartToAdd>((event, emit) async {

      // TODO: implement event handler


      List<CartItem>? curr = state.itemcart;
      var isupdate = false;
      int index = -1;

      state.itemcart!.forEach((element) {
        // 1 < 3
        // 2 < 3
        // 3 <= 3
        // 4 <= 3
        if(element.stockqty  == 0) {
          print("Product qty in stock: ");
          print(element.stockqty);
          return ;
        }
        else {
          if(element.productid == event.cartitem!.productid &&
              element.colorid == event.cartitem!.colorid
          ) {


            isupdate = true;
            print(element.qty);
            index =state.itemcart!.indexOf(element);

          }
        }


      });

      print(index);
      print(isupdate);
      if(isupdate == true) {
        print("Already existed ----");
        CartItem cartitem = state.itemcart![index];
        print(cartitem.stockqty); //2
        print(cartitem.qty); //1
        print("My Cart Qty");
        print(cartitem.qty);
        print(cartitem.stockqty); //2
        var totalqty = 0;
        List<CartItem>? cartitems =  state.itemcart?.where((e) => e.productid == event.cartitem?.productid).toList();
        print(cartitems);
        cartitems?.forEach((element) {
          totalqty += element.qty!;
        });
        print("Total qty product is ${totalqty}");

        if(cartitem.qty == cartitem.stockqty ){
          print("Product qty in stock: ");

        }
        else {
          print("Cart No Itmes");
          cartitem!.qty =    cartitem!.qty!  + 1;
          curr!.removeAt(index);



          curr!.insert(index, cartitem);
          print(curr);
        }

      }
      else {
        print("Does not exist");
        print(index);
        // print(event.cartitem!.stockqty);
        print(event.cartitem!.qty);
        // var cartitem= state.itemcart?.firstWhere((element) => element.cartid == event.cartitem?.cartid);
        //       print(cartitem!.qty!);
        //       if ( cartitem!.qty! <=  event.cartitem!.qty!) {


        curr!.add(event!.cartitem!);
        // Save the updated cart to SharedPreferences


        // Print the cart items

        // }

        // }
      }




      emit(AllCart(itemcart: curr));



      // emit(CartToAdd());

      //TODO getthe even add
    });


    on<CartToRemove>((event, emit) async {
      // TODO: implement event handler
      print("Event Cart to Remove Send to bloc");

      List<CartItem>? curr = state.itemcart;

      CartItem? item =curr?.firstWhere((element) => element.cartid == event.cartitem!.cartid);
      int index = curr!.indexOf(item!);
      if(     item!.qty! > 0){
        item!.qty =   item!.qty! - 1;

        print(index);
        curr.removeAt(index);
        curr.insert(index, item);
      }
     if(item!.qty! == 0){
        item!.qty = 0;

        curr!.removeAt(index);


      }
      emit(AllCart(itemcart: curr));


      // emit(CartToAdd());

      //TODO getthe even add
    });
    on<CartRemoveAll>((event, emit) async  {
      // TODO: implement event handler
      print("Event Cart to Remove Send to bloc");

      List<CartItem>? curr = state.itemcart;

      CartItem? item =curr?.firstWhere((element) => element.cartid == event.cartitem!.cartid);
      int index = curr!.indexOf(item!);



      curr!.removeAt(index);


      emit(AllCart(itemcart: curr));


      // emit(CartToAdd());

      //TODO getthe even add
    });
    on<CartClear>((event, emit) async  {
      // TODO: implement event handler
      print("Event Cart to Clear Send to bloc");

      List<CartItem>? curr = state.itemcart;
      curr!.clear();


      emit(AllCart(itemcart: curr));

      // emit(CartToAdd());

      //TODO getthe even add
    });
  }
}
