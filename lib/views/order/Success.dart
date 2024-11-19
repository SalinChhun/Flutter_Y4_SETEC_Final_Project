import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/order/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/Order/OrderResponse.dart';
import '../client/NavScreen.dart';
import 'CompleteOrder.dart';

class Success extends StatefulWidget {
  OrderReponse? order;

  Success({Key? key,this.order}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(

          title: Text('Order Completed', style: TextStyle(
              color: Colors.white,
          ),),

          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          backgroundColor: Colors.black,
          elevation: 0,
          automaticallyImplyLeading: false  ,


        ),
        body: SafeArea(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                Lottie.asset('assets/logo/success.json'),
                // Icon(Icons.check,size: 60,color: Color(AppColorConfig.success),),

                Text("Completed", style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge,),

                SizedBox(height: 10,),

                Text(
                  "Your Order has been placed !!! ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.8,
                  ),
                  textAlign: TextAlign.center,
                ),








              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


        floatingActionButton: Row(


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
                    BlocProvider.of<OrderBloc>(context,listen: false).add(GetOrderDetail(orderid: widget.order?.id));

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                      return CompletedOrder();
                    },),(route) => false  );


                  }, child: Text("Done",style: TextStyle(
                fontSize: 20
              ),)),
            ),
          ],
        )
    );
  }
}
