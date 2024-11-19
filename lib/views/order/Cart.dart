import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/cart/cart_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helper/HexColorConverter.dart';
import '../../model/Product/CartModel.dart';
import '../../viewmodel/products/address_bloc.dart';
import '../widget/Product/CustomButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/other/EmptyWidget.dart';
import 'Checkout.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CartScreen extends StatefulWidget {
  var discount ;
   CartScreen({Key? key,this.discount}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {



var cartlength = 0;
int? userid;
var imgindexx =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // context.read<CartBloc>().add(CartToLoaded());
    GetUserSharePrefs();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

          title: Text("My Cart", style: TextStyle(
              color: Colors.black
          ),),
          iconTheme: IconThemeData(
              color: Colors.black
          ),

          backgroundColor: Colors.white,
          elevation: 0),
      body: SafeArea(

        child: BlocConsumer<CartBloc, AllCart>(
          listener: (context, state) {
            // TODO: implement listener
            print(state);

            ScaffoldMessenger.of(context).hideCurrentSnackBar();
           setState(() {
              cartlength = state.itemcart?.length ?? 0;
              print(state.itemcart?.length);

         });
            if(cartlength == 0 || cartlength == null) {


            }
            // ScaffoldMessenger.of(context).hideCurrentSnackBar();

              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Added to cart") ));



          },
          builder: (context, state) {
            print("Item cart is ");
            print(state.itemcart);
            if (state.itemcart?.length == 0 || state.itemcart == null  ) {
              return EmptyCard(
                maintitle: 'Opps Your Cart is Empty',

                subtitle: 'Check out our store product right away',
              img: 'assets/logo/shoppingbag.jpg',
                btntitle: 'Order Now',

              );
            }


            else {
              return Container(
                height: MediaQuery.of(context).size.height*0.7,
                padding:  EdgeInsets.all(10),
                child: ListView.builder(




                  scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: state.itemcart?.length ?? 0,

                itemBuilder: (context, index) {
                  var cart = state.itemcart![index];
                  Color colorcode = HexColor(cart.colorid.code);
                  print(cart.colorid.code);
                  return Card(
                    elevation: 0,
                   // color: Color(AppColorConfig.primarylight),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.grey.withOpacity(0.35)
                        )
                    ),
                    child: ListTile(
                      isThreeLine: true,
                      style: ListTileStyle.drawer,
                      contentPadding: EdgeInsets.all(14),

                      leading: Image.network(
                          '${cart.imgurl}',





                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            width: 230,
                            child: Text('${cart.producttitle}',
                              maxLines: 2,
                            overflow: TextOverflow.ellipsis,

                              style: TextStyle(
                              fontSize: 16,

                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis

                            ),),
                          ),
                          InkWell(
                            onTap: () {
                              BlocProvider.of<CartBloc>(
                                  context, listen: false).add(
                                  CartRemoveAll(
                                      cartitem: CartItem(
                                    discount: cart.discount,
                                    qty: cart.qty,
                                    cartid: cart.cartid,
                                    productid: cart.productid,
                                    attribution: cart.attribution,
                                    imgurl: cart.imgurl,
                                    price: cart.price,
                                    producttitle: cart.producttitle,

                                  )));
                            },
                            child: Icon(
                              Icons.delete, color: Color(0xffC73737), size: 27,),
                          ),

                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2,),

                          Row(
                            children: [
                              Text('Size: ${cart.sizetext} ', style: TextStyle(
                                  fontSize: 12.8,

                              ),),
                              Text('Color:  ', style: TextStyle(
                                  fontSize: 12.8,


                              ),),
                            Container(
                              width: 17,
                              margin: EdgeInsets.only(right: 5),
                              height: 17,
                              // child: Text(attri?.colorid[index].code),
                              decoration: BoxDecoration(
                                  color:colorcode,
                                  borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5)
                                )

                              ),
                            )


                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(


                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Text('\$ ${cart.price.toStringAsFixed(2)}',style: TextStyle(
                                    fontSize: 18.9,
                                    fontWeight: FontWeight.w500,
                                    color: Color(AppColorConfig.success)
                                ),),

                                Container(
                                  padding: EdgeInsets.only(left: 15,right: 15),

                                  decoration: BoxDecoration(
                                    color: Color(AppColorConfig.primarylight),
                                    borderRadius: BorderRadius.circular(25),



                                  ),
                                  child: Row(
                                    children: [

                                      InkWell(
                                          onTap: () {
                                            BlocProvider.of<CartBloc>(
                                                context, listen: false).add(
                                                CartToRemove(cartitem: CartItem(
                                                  discount: cart.discount,
                                                  qty: cart.qty,
                                                  cartid: cart.cartid,
                                                  productid: cart.productid,
                                                  attribution: cart.attribution,
                                                  imgurl: cart.imgurl,
                                                  price: cart.price,
                                                  producttitle: cart.producttitle,
                                                  sizeid: cart.sizeid,
                                                  colorid: cart.colorid,
                                                  imgid: cart.imgid,


                                                )));
                                          },

                                          child:  Container(
                                            child: Text("-",style: TextStyle(
                                                fontSize: 29,
                                                color: Color(AppColorConfig.success)
                                            ),),
                                          )),
                                      SizedBox(width: 16,),
                                      Text('${cart.qty}',style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black
                                      ),),
                                      SizedBox(width: 16,),
                                      InkWell(
                                          onTap: () {
                                            print("Cart");

                                            print(cart.qty);

                                            print("Product");
                                            print(state!.itemcart![index].qty);
                                            if(cart.qty! < state!.itemcart![index].stockqty! ) {
                                              print("True");
                                              BlocProvider.of<CartBloc>(
                                                  context, listen: false).add(
                                                  CartToAdd(cartitem: CartItem(
                                                    discount: cart.discount,
                                                    cartid: DateTime.now(),
                                                    qty: cart.qty,
                                                    productid: cart.productid,
                                                    attribution: cart.attribution,
                                                    imgurl: cart.imgurl,
                                                    price: double.parse( cart.price.toStringAsFixed(2)),
                                                    producttitle: cart.producttitle,
                                                    sizeid: cart.sizeid,
                                                    colorid: cart.colorid,
                                                    imgid: cart.imgid,


                                                  )));
                                            }
                                            else {
                                              print("True");

                                              ScaffoldMessenger.of(context).showSnackBar(

                                                  SnackBar(
                                                    width: 340,

                                                    duration: Duration(
                                                        milliseconds: 1000
                                                    ),


                                                    content: Container(
                                                      height: 70,

                                                      width: 270,
                                                      padding: EdgeInsets.all(15),
                                                      alignment: Alignment.center,

                                                      //color: Colors.white,
                                                      decoration: BoxDecoration(
                                                          color: Color(AppColorConfig.negativelight),
                                                          // border: Border.all(width: 0, color:Color(AppColorConfig.negativelight)),
                                                          borderRadius: BorderRadius.circular(15)),
                                                      margin: EdgeInsets.all(10),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(0.0),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(width: 20,),
                                                            Icon(Icons.shopping_cart,color: Color(AppColorConfig.negativecolorv2),size: 20,),
                                                            SizedBox(width: 10,),
                                                            Text('Insufficient Product Stock',style: TextStyle(
                                                                color: Color(AppColorConfig.negativecolorv2),
                                                                fontSize: 16
                                                            ),),
                                                          ],
                                                        ),
                                                      ),
                                                    ), backgroundColor: Colors.transparent,



                                                    elevation: 0, behavior: SnackBarBehavior.floating,)
                                              );
                                            }


                                         },
                                          child: Container(
                                            child: Text("+",style: TextStyle(
                                              fontSize: 29,
                                              color: Color(AppColorConfig.success)
                                            ),),
                                          )


                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      // trailing: ,
                    ),

                  );
                },),
              );
            }
          },
        ),
      ),
      bottomSheet:


      BlocConsumer<CartBloc, AllCart>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          double total = 0;
          var qtytotal = 0;
          state.itemcart?.forEach((element) {
            print(element.price);
            print(element.discount);

            // var price =element!.price - ( element!.price * (double.parse( element.discount.toString() )/100)).truncateToDouble();
            total += (element.price *  element.qty);
            qtytotal += element!.qty!;

          });
          return
            state.itemcart?.length == 0  ?
            Container(
              height: 1,
            ) :

            state.itemcart != null  ?
            Container(

            decoration: BoxDecoration(
              color: Colors.white,


            ),
            width: double.maxFinite,
            padding: EdgeInsets.all(15),
            height: 190,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Products Item', style: TextStyle(
                        fontSize: 12.8,
                        color: Colors.grey
                    ),),
                    Text(' ${state.itemcart?.length ?? 0}', style: TextStyle(
                        fontSize: 12.8,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Fees', style: TextStyle(
                        fontSize: 12.8,
                        color: Colors.grey
                    ),),
                    Text(' FREE ', style: TextStyle(
                        fontSize: 12.8,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     // Text('Discount', style: TextStyle(
                //     //     fontSize: 12.8,
                //     //     color: Colors.grey
                //     // ),),
                //     Text('\% ${cart.discount}', style: TextStyle(
                //         fontSize: 12.8,
                //         color: Colors.black,
                //         fontWeight: FontWeight.w500
                //     ),)
                //   ],
                // ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal', style: TextStyle(
                        fontSize: 15.8,
                        color: Colors.black
                    ),),
                    Text('\$ ${total.toStringAsFixed(2)?? 0}', style: TextStyle(
                        fontSize: 15.8,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
           SizedBox(height: 14,),

           ElevatedButton(

              onPressed: () {
            print("Press click");
            Navigator.push(context, MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) {
              return Checkout(
                cartitem: state.itemcart,
                discount: widget.discount,




                qtytotal: qtytotal,

                subtotal: double.parse(total.toStringAsFixed(2)),
                uid: userid,


                

              );
            },));



          },
          style: ElevatedButton.styleFrom(
          backgroundColor:Color(AppColorConfig.success),
          elevation: 0,
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            // side: BorderSide(color: Color(AppColorConfig.success))
          side: BorderSide(color: Colors.black.withOpacity(0.14)),
          // borderRadius: BorderRadius.circular(10)
          )
          ),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          // Image.asset('assets/logo/shopping-cart.png',
          // width: 20,
          // height: 20,
          // fit: BoxFit.cover,
          //
          // ),

          SizedBox(width: 10,),
          Text("Proceed to Checkout",style: TextStyle(
          fontSize: 14.8,

          ),)
          ],
          ))

              ],
            ),
          ) :

            Container(
              height: 1,
            );
        },
      )
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton:     Container(
      //
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //
      //
      //   ),
      //   width: double.maxFinite,
      //   padding: EdgeInsets.all(15),
      //   height: 180,
      //   child: Column(
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text('Product Price',style: TextStyle(
      //             fontSize: 12.8,
      //             color: Colors.grey
      //           ),),
      //           Text('\$ 120',style: TextStyle(
      //               fontSize: 12.8,
      //               color: Colors.black,
      //             fontWeight: FontWeight.w500
      //           ),)
      //         ],
      //       ),
      //       Divider(),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text('Discount',style: TextStyle(
      //               fontSize: 12.8,
      //               color: Colors.grey
      //           ),),
      //           Text('\% 0',style: TextStyle(
      //               fontSize: 12.8,
      //               color: Colors.black,
      //               fontWeight: FontWeight.w500
      //           ),)
      //         ],
      //       ),
      //       Divider(),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text('Subtotal',style: TextStyle(
      //               fontSize: 12.8,
      //               color: Colors.grey
      //           ),),
      //           Text('\$ 120',style: TextStyle(
      //               fontSize: 12.8,
      //               color: Colors.black,
      //               fontWeight: FontWeight.w500
      //           ),)
      //         ],
      //       ),
      //       Divider(),
      //       ElevatedButton(onPressed: () {
      //
      //       },
      //           style: ElevatedButton.styleFrom(
      //               backgroundColor: Colors.black,
      //               elevation: 0,
      //               shape: RoundedRectangleBorder(
      //                   side: BorderSide(color: Colors.black.withOpacity(0.14)),
      //                   borderRadius: BorderRadius.circular(3)
      //               )
      //           ),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Image.asset('assets/logo/shopping-cart.png',
      //                   width: 20,
      //                   height: 20,
      //                   fit: BoxFit.cover,
      //
      //               ),
      //               SizedBox(width: 10,),
      //               Text("Proceed to Checkout",style: TextStyle(
      //                   fontSize: 12.8,
      //
      //               ),)
      //             ],
      //           )),
      //
      //     ],
      //   ),
      // ),

    );
  }

  PushScreen(BuildContext context,userid) {

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Checkout(uid: userid,);
    },));
  }

  void GetUserSharePrefs() async {
    
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("object ${prefs.getInt("userid")}");
    userid = prefs.getInt("userid");
  }
}




