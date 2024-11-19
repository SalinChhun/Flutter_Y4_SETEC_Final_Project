import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/res/appurl/appurl.dart';
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/order/order_bloc.dart';
import 'package:ecommerce/views/order/Tracking.dart';
import 'package:ecommerce/views/widget/LoadingIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/views/client/NavScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../model/Order/OrderDetail.dart';
import '../../model/Order/OrderRequest.dart';
import '../../res/constant/stripesecretkey.dart';
import '../client/ReportBug.dart';
import '../client/Review/ReviewPopUp.dart';
import '../client/product/MyProduct.dart';
import '../client/product/Product.dart';
import '../widget/Product/PaymentPopUp.dart';
import 'Success.dart';


class TrackingScreen extends StatefulWidget {
  var appbar;
  var orderid;

  TrackingScreen({Key? key, this.appbar,this.orderid}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}




void ReviewAlert(BuildContext context,OrderList orderList) {

  showDialog(context: context, builder: (context) {
    return AlertReviewPop(orderList: orderList,);
  },);
}
class _TrackingScreenState extends State<TrackingScreen> {
  int? totalqty = 0;
  List<Productss>? globalitem =[];
  var order;
  var orderDetail;
  var initpayment = 0;

  Map<String, dynamic>? paymentintent;

  var uuid;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<OrderBlocUser>(context,listen: false).add(GetOrderDetail(orderid: widget.orderid));
  }
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        title: Text('${widget.appbar ?? 'Tracking'}', style: TextStyle(
            color: Colors.white
        ),),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
            
            
            child: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,)),
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.black,
        elevation: 0,


      ),
      body: SafeArea(
        child: BlocConsumer<OrderBlocUser, OrderState>(
  listener: (context, state) {

    print(state);
    // TODO: implement listener
    if(state is OrderLoading) {
           LoadingIcon();
    }
    if(state is OrderSuccessCompleted) {
      print("Success Again reorderOrderUserComplete");
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Success(order: state?.orderReponse,)));
      });
      //TODO use this whenever u want to push neww screen after state updated
      // Navigator.push(context, MaterialPageRoute(
      //   builder: (context) {
      //   return Success();
      // },));
    }


    if(state is OrderDetailSuccess) {
      print("THe order");
      print(  state?.orderDetail?.status!.toLowerCase());
     if(     state?.orderDetail?.status!.toLowerCase() == "completed" ){
       print("THe order again");

       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
         ReviewAlert(context,  state!.orderDetail!);
       });

     }


    }
    if(state is OrderStripePending) {
      showDialog(context: context, builder: (context) {


        return  Center(

          child: CircularProgressIndicator(
            color: Color(AppColorConfig.bgcolor),

          ),
        );

      },);




      OrderRequestV2 order = OrderRequestV2(

          customer:uuid,

          method: "Online",
          productss:globalitem

      );

      BlocProvider.of<OrderBlocUser>(context,listen: false).add(PostOrderEvent( addressid:

      orderDetail
          ,orderRequestV2: order));
    }
  },
  builder: (context, state) {
    if(state is OrderDetailSuccess) {

      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [


              Container(


                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery Status", style: TextStyle(

                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),),


                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    //TODO tracking line order here
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:

                                    state?.orderDetail?.status!.toLowerCase() == "pending" ?
                                    Colors.green :
                                    Color(0xffD9D9D9)
                                    ,


                                  ),
                                  SizedBox(height: 10,),
                                  Text('Pending', style: TextStyle(
                                      fontSize: 12.8
                                  ),)
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: Divider(


                                    color:

                                    Colors.grey,
                                    thickness: 1,
                                    height: 3,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),


                        Expanded(
                          child: Row(

                            children: [
                              Column(
                                children: [
                                  CircleAvatar(

                                      backgroundColor:
                                state?.orderDetail?.status!.toLowerCase() == "delivering" ?
                                Colors.green :

                                 Color(0xffD9D9D9)

                                  ),
                                  SizedBox(height: 10,),
                                  Text('Delivering', style: TextStyle(
                                      fontSize: 12.8
                                  ),)
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 24),


                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                    height: 3,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),

                        Column(
                          children: [
                            CircleAvatar(
                                backgroundColor:

                                state?.orderDetail?.status == "Completed" ?
                                Colors.green :

                                Color(0xffD9D9D9)
                            ),
                            SizedBox(height: 10,),
                            Text('Completed', style: TextStyle(
                                fontSize: 12.8
                            ),)
                          ],
                        ),


                      ],
                    ),
                    SizedBox(height: 20,),


                  ],
                ),
              ),
              Lottie.asset('assets/lotties/animation_ln8xphws.json'),
              Divider(),

              //TODO orde detail here
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Order #${widget.orderid}", style: TextStyle(

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
                            Icon(Icons.add_ic_call_sharp, size: 15,),
                            SizedBox(width: 10,),
                            Icon(Icons.email, size: 15,),
                          ],
                        ),),
                    )


                  ],
                ),
              ),
              Divider(),

              ListView.builder(
                itemCount: state.orderDetail?.products?.length ?? 0,
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                   order= state.orderDetail?.products![index];
                   var pro = state.orderDetail?.products![index];

                  totalqty = (totalqty! + order!.quantity!) as int?;
                  return Container(

                    margin: EdgeInsets.only(bottom: 10),


                    child: ListTile(
                      onTap: () async {

                        SharedPreferences prefs= await SharedPreferences.getInstance();
                        Navigator.push(context,MaterialPageRoute(builder: (context) {
                          // print(widget.product!.id);
                          // print( widget.product!.imgid![0].images);
                          // print(widget.product!.price);
                          // print(widget.product!.category?.id);
                          // print( widget.product!.attribution);
                          // print(widget.product!.discount);
                          // print(widget.product!.avgRating);
                          // print(  widget.product!.description);
                          // print( widget.product!.sellRating);
                          // print( widget.product!.productname);
                          // print( widget.product!.stockqty);

                          return ProductDetailScreen(
                              userid: prefs.getInt("userid"),
                              isorderview: true,
                              productss: MyProductDetail(
                                  id:pro?.product?.id ,
                                  imgid: pro?.product?.imgid,
                                  price: pro?.product?.price,
                                  categoryid:pro?.product?.category?.id,
                                  attribution: pro?.product?.attribution,
                                  discount:  pro?.product?.discount,
                                  avgRating:  pro?.product?.avgRating,
                                  description:  pro?.product?.description,
                                  sellRating: pro?.product?.sellRating,
                                  productname: pro?.product?.productname,
                                  stockqty: pro?.product?.stockqty
                              ));

                        },));

                      },


                      contentPadding: EdgeInsets.all(0),
                      leading:
                      CachedNetworkImage(
                        // imageUrl: "https://fakeimg.pl/300x150?text=+",
                        imageUrl: "https://django-ecomm-6e6490200ee9.herokuapp.com"+ order.colorselection!.imgid!.images!.toString(),
                        width: 100,
                        height: double.maxFinite
                          , fit: BoxFit.contain,

                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            Center(child:
                            Image.network( "https://fakeimg.pl/300x150?text=+"
                              ,fit: BoxFit.cover,width: double.maxFinite,height: double.maxFinite,)

                            ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      // Image.network(
                      //   '${ApiUrl.main}${order.colorselection?.imgid?.images}'
                      //
                      //   , fit: BoxFit.contain,
                      //   width: 100,
                      //   height: double.maxFinite,
                      // ),

                      title: Text('${order?.product?.productname}', style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text('\$ ${
                              (order.colorselection?.price  - (  order.colorselection?.price
                                  *  state.orderDetail?.products![index].product?.discount / 100)).toStringAsFixed(2)


                          }',
                            style: TextStyle(
                              fontSize: 14.8,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff508A7B)
                          ),),
                          Row(
                            children: [
                              Text("Total: ",style: TextStyle(
                                  fontSize: 14.8,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff508A7B)
                              ),),
                              Text('\$ ${
                                  (order.colorselection?.price  * (  order.quantity )).toStringAsFixed(2)


                              }', style: TextStyle(
                                  fontSize: 14.8,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff508A7B)
                              ),),
                            ],
                          )

                        ],
                      ),
                      trailing: Text('Qty: ${order?.quantity}', style: TextStyle(
                          fontSize: 12.8,

                          fontWeight: FontWeight.w400
                      ),),

                    ),
                  );
                },),
              Container(
                height: 300,

                child: Column(
                  children: [

                    //TODO product summary
                    Container(
                      margin: EdgeInsets.only(bottom: 15, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Payment Method', style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.8
                          ),),
                          Text('${state.orderDetail?.method}'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Price', style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.8
                          ),),
                          Text('\$ ${state.orderDetail?.amount}'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child:

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Delivery Fees', style: TextStyle(

                              color: Colors.grey
                          ),),
                          Text(' FREE ', style: TextStyle(

                              color: Colors.black,
                              fontWeight: FontWeight.w500
                          ),)
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.only(bottom: 0, top: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xffC2E5DF)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('SubTotal', style: TextStyle(
                              color: Color(AppColorConfig.success),
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ),),
                          Text('\$ ${state.orderDetail?.amount}',style: TextStyle(
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
          ),
        ),
      );

    }
    if(state is OrderDetailError){
      return Center(
        child:  Text('Error during server sending'),
      );
    }
    if(state is OrderDetailLoading){
      return        LoadingIcon();
    }
    else{
      return        LoadingIcon();
    }


  },
),
      ),
      bottomNavigationBar:      BlocConsumer<OrderBlocUser, OrderState>(
  listener: (context, state) {
    print(state);
    print("The state is ${state}");
    // TODO: implement listener
    if(state is OrderLoading) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Center(
          child: CircularProgressIndicator(),
        );
      });

    }
    if(state is OrderSuccessCompleted) {
      print("Success reorder");

        // Navigator.pushReplacement(context,
        //
        //     MaterialPageRoute(builder: (_) => Success(order: state?.orderReponse,)));


        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
         return Success(order: state?.orderReponse,);
        },), (route) => false);

      //TODO use this whenever u want to push neww screen after state updated
      // Navigator.push(context, MaterialPageRoute(
      //   builder: (context) {
      //   return Success();
      // },));
    }
  },
  builder: (context, state) {
    // if(state is OrderSuccessCompleted) {
    //   print("Success");
    //   WidgetsBinding.instance!.addPostFrameCallback((_) {
    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Success(order: state?.orderReponse,)));
    //   });
    //   //TODO use this whenever u want to push neww screen after state updated
    //   // Navigator.push(context, MaterialPageRoute(
    //   //   builder: (context) {
    //   //   return Success();
    //   // },));
    // }
    if(state is OrderDetailSuccess) {

      print("Order Succes Here");
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(

          children: [
            Expanded(
              child: FloatingActionButton.extended(
                  backgroundColor: Color(AppColorConfig.success),

                  elevation: 0,
                  isExtended: true,
                  extendedPadding: EdgeInsets.all(0),

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)
                  ),
                  onPressed: () async {
                    //TODO submit order
                    //TODO do some event
                    //TODO submit order
                    //TODO do some event

                    List<Productss>? item =[];

                    for(int index=0;index<state!.orderDetail!.products!.length;index++) {
                      item.add(Productss(
                        id: state!.orderDetail!.products![index].product?.id,
                        quantity:  state!.orderDetail!.products![index].quantity,
                        colorselection: state!.orderDetail!.products![index].colorselection!.id,
                        size:  state!.orderDetail!.products![index].size?.id,


                      ));
                    }
                    //TODO gloabl here
                    globalitem?.addAll(item);
                    orderDetail =   state!.orderDetail!.address!.id;


                    print("Item in cart");
                    print(item.length);
                    //TODO orderrequest
                    print(item);
                    SharedPreferences prefs = await SharedPreferences.getInstance();

                    uuid = prefs.getInt('userid');




                   initpayment = await showDialog(context: context, builder: (context)

                    {
                        return PaymentPopUp();
                    },);

                   setState(() {
                     print(initpayment);
                   });
                   if(initpayment == null) {
                     return;
                   }

                   if(initpayment == 0) {
                     OrderRequestV2 order = OrderRequestV2(

                         customer:prefs.getInt("userid"),

                         method: "Cash",
                         productss:item

                     );

                    context.read<OrderBlocUser>().add(PostOrderEvent( addressid:

                     state!.orderDetail!.address?.id
                         ,orderRequestV2: order));


                   }
                   if(initpayment == 1) {
                     makePayment(currency:"USD",totalamount:double.parse(state.orderDetail!.amount!).ceil().toString()).then((value) {
                       print("Success");



                     }).catchError((err) {
                       print(err);

                     });
                     // OrderRequestV2 order = OrderRequestV2(
                     //
                     //     customer:prefs.getInt("userid"),
                     //
                     //     method: "Online",
                     //     productss:item
                     //
                     // );
                     //
                     // BlocProvider.of<OrderBlocUser>(context,listen: false).add(PostOrderEvent( addressid:
                     //
                     // state!.orderDetail!.address?.id
                     //     ,orderRequestV2: order));
                   }





                  }, label:Row(
                children: [
                  Icon(Icons.restart_alt),
                  Text('Reorder',style: TextStyle(
                      fontSize: 14.8
                  ),),
                ],
              )),
            ),
          ],
        ),
      );
    }

    else{
      return        LoadingIcon();
    }

  },
),

    );
  }


  String calculateAmount(String amount) {
    return ((int.parse(amount)) * 100).toString();
  }

  Future<void> makePayment({totalamount,currency}) async {
    print("payment");
    try {
      paymentintent = await createPaymentIntent(totalamount.toString(), 'USD');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentintent!['client_secret'],
              style: ThemeMode.light,
              merchantDisplayName: 'Adnan')).then((value) {

      });
      // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92'),
      // googlePay: const PaymentSheetGooglePay(merchantCountryCode: )
      //after successfully paid
      displayPaymentSheet();
      // Navigator.pop(context);
    } catch (err) {
      print('send response error');
      print(err.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(

      ).then((value) {

        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text('Payment Successfully'),
          );
        },);
        paymentintent = null;
        context.read<OrderBloc>().add(OrderStripe());
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        print("error is --- ${error}");
      });
    } on StripeException catch (e) {
      print("Stripe error catching ${e}");
      await Stripe.instance.presentPaymentSheet(

      ).then((value) {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text('Error has been occur'),
          );
        },);
        paymentintent = null;
      }).onError((error, stackTrace) {
        print("error is --- ${error}");
      });
    }
  }


  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var res = await http.
      post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
          headers: {
            'Authorization': 'Bearer ${SecretKey.key}',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: body
      );
      print("Payment body: ${res.body.toString()}");
      return json.decode(res.body);
    } catch (error) {
      print('  createPaymentIntentresponse error');
      print(error.toString());
    }
  }



}
