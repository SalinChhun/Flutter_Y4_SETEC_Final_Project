

import 'package:ecommerce/viewmodel/cart/cart_bloc.dart';
import 'package:ecommerce/viewmodel/order/order_bloc.dart';
import 'package:ecommerce/views/client/NavScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../helper/HexColorConverter.dart';
import '../../res/appurl/appurl.dart';
import '../../res/constant/appcolor.dart';
import '../client/ReportBug.dart';
import '../client/Review/ReviewPopUp.dart';
import '../widget/LoadingIcon.dart';
class CompletedOrder extends StatefulWidget {

  const CompletedOrder({Key? key}) : super(key: key);

  @override
  State<CompletedOrder> createState() => _CompletedOrderState();
}
void ReviewAlert(BuildContext context) {

  showDialog(context: context, builder: (context) {
    return AlertReviewPop();
  },);
}
class _CompletedOrderState extends State<CompletedOrder> {
  int subqty = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(

        title: Text('Order Summary',style: TextStyle(
            color: Colors.white
        ),),
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.black,
        elevation: 0,


      ),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: BlocConsumer<OrderBloc, OrderState>(
  listener: (context, state) {
    // TODO: implement listener
    print(state);
  },
  builder: (context, state) {
    if(state is OrderDetailSuccess) {

      var cartlen = state.orderDetail?.products!.length ?? 0;
      var urlimg =  "https://django-ecomm-6e6490200ee9.herokuapp.com";

      print(cartlen);
      return Column(
        children: [

          ListView.builder(

            itemCount: cartlen,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var cart =  state.orderDetail?.products;
              Color colorcode = HexColor(cart![index].colorselection!.code!);

              for(int i =0;i<state.orderDetail!.products!.length;i++)
                subqty += state.orderDetail!.products![i].quantity!.toInt();
              return Container(

                margin: EdgeInsets.only(bottom: 10),



                child: ListTile(
                  onTap: () {

                  },



                  contentPadding: EdgeInsets.all(14),
                  leading:

                  // Image.network(
                  //     '${urlimg}${cart![index].colorselection?.imgid?.images}'
                  //
                  //
                  //
                  //
                  //
                  // ),
                  CachedNetworkImage(
                    // imageUrl: "https://fakeimg.pl/300x150?text=+",
                    imageUrl: urlimg + cart![index].colorselection!.imgid!.images!,
                    width: 80,
                    height: 180,
                    fit: BoxFit.cover,

                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        Center(child:
                        Image.network( "https://fakeimg.pl/300x150?text=+"
                          ,fit: BoxFit.cover,)

                        ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Expanded(
                        child: Text('${cart![index].product!.productname!}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                          style: TextStyle(
                          fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400,

                        ),),
                      ),


                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Size: ${cart[index].size?.size} ', style: TextStyle(
                            fontSize: 12.8,

                          ),),
                          // Text('Color: ${cart[index].colorselection?.color} ', style: TextStyle(
                          //   fontSize: 12.8,
                          //
                          // ),),
                          Text('Color:  ', style: TextStyle(
                            fontSize: 11.8,

                          ),),
                          Container(
                            width: 12,
                            margin: EdgeInsets.only(right: 5),
                            height: 12,
                            // child: Text(attri?.colorid[index].code),
                            decoration: BoxDecoration(
                                color:colorcode,
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5)
                                )

                            ),
                          ),
                          Text('\ Total: \$ ${ (cart![index].colorselection!.price! * (cart![index].quantity!)).toStringAsFixed(2)}',

                            style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                                color: Color(AppColorConfig.success)
                            ),),

                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(


                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                        // element!.price - ( element!.price * (double.parse( element.discount.toString() )/100)).truncateToDouble();
                            Text('\$ ${
                            (cart[index].colorselection!.price! - ( cart[index].colorselection!.price! *
                                (double.parse( cart[index].product!.discount.toString() )/100))).toStringAsFixed(2)
                            }',style: TextStyle(
                                fontSize: 18.9,
                                fontWeight: FontWeight.w500,
                                color: Color(AppColorConfig.success)
                            ),),


                          ],
                        ),
                      ),

                    ],
                  ),

                  // title:
                  // Text('${cart![index].product!.productname!}',style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w500
                  // ),),
                  // subtitle: Text('\$ ${cart![index].product!.price!}',style: TextStyle(
                  //     fontSize: 16.8,
                  //     fontWeight: FontWeight.w500,
                  //     color: Color(0xff508A7B)
                  // ),),
                  trailing: Text('Qty: x ${cart![index].quantity!}',style: TextStyle(
                      fontSize: 12.8,

                      fontWeight: FontWeight.w400
                  ),),

                ),
              );
            },),

          Container(
            height: 300,

            child:Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Order # ${state.orderDetail?.id}",style: TextStyle(

                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      ),),

                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ReportScreen();
                        },)),
                        child: Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Color(0xffF5F5F5),

                          ),
                          child: Row(
                            children: [
                              Text('Need Help?'),
                              SizedBox(width: 20,),
                              Icon(Icons.add_ic_call_sharp,size: 15,),
                              SizedBox(width: 10,),
                              Icon(Icons.email,size: 15,),
                            ],
                          ),),
                      )



                    ],
                  ),
                ),
                Divider(),
                //TODO product summary
                Container(
                  margin: EdgeInsets.only(bottom: 15,top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment status",style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.8
                      ),),

                      Text(' ${state?.orderDetail?.ispaid == false  ? 'Not Paid' : 'Paid'}'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Price',style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.8
                      ),),
                      Text('\$ ${state?.orderDetail?.amount}'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Payment method',style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.8
                      ),),
                      Text('${state.orderDetail?.method}'),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.only(bottom: 0,top: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xffC2E5DF)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SubTotal',style: TextStyle(
                          color: Color(AppColorConfig.success),
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),),
                      Text('\$ ${state?.orderDetail?.amount}',style: TextStyle(
                          fontWeight: FontWeight.w500,
                        color: Color(AppColorConfig.success),
                        fontSize: 18,
                      ),),
                    ],
                  ),
                ),

              ],
            ),
          ),

        ],
      );
    }
    if(state is OrderDetailError){
      return  LoadingIcon();
    }
    if(state is OrderDetailLoading){
      return  Center(child: LoadingIcon());
    }
    else{
      return  LoadingIcon();
    }


  },
),
          ),
        ),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        floatingActionButton:Row(

          children: [
            Expanded(

              child:
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,


                      padding: EdgeInsets.all(15),

                      backgroundColor: Color(AppColorConfig.success),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                      )
                  ),
                  onPressed: () {
                    BlocProvider.of<CartBloc>(context,listen: false).add(CartClear());


                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                      return MyNavScreen();
                    },),(route) => false  );


                  }, child: Text("Continue Shopping",style: TextStyle(
                  fontSize: 16
              ),)),
            ),
          ],
        )
    );
  }
}
