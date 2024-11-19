
import 'package:ecommerce/model/Product/CartModel.dart';
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/Review/review_bloc.dart';
import 'package:ecommerce/views/widget/LoadingIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../model/Category/ProductCategory.dart';
import '../../../model/Product/ProductModel.dart';
import '../../../model/Review/ReviewModel.dart';
import '../../../viewmodel/cart/cart_bloc.dart';
import '../../order/Cart.dart';
import '../../order/Checkout.dart';
import '../Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../NavScreen.dart';
import 'Review.dart';
import 'ReviewModify.dart';



class ReviewList extends StatefulWidget {
  var pid;
  var pname;
  var pimage;
  var star;

  ReviewList({this.pid,this.pname,this.pimage,this.star});

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  var product;
  var starpoint ;
  var liststar =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for(int i =0;i<5;i++) {
      liststar.add(i);
    }
  }



  Widget build(BuildContext context) {

    context.read<ReviewBloc>().add(ReviewFetch(pid: widget.pid));


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

          title: Text("Review", style: TextStyle(
              color: Colors.black
          ),),
          centerTitle: true,
          titleSpacing: 0,
          iconTheme: IconThemeData(
              color: Colors.black
          ),
          // centerTitle: true,
          backgroundColor: Colors.white.withOpacity(0.34),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.all(11.0),
          //     child: Icon(Icons.edit_sharp,size: 22,),
          //   )
          // ],
          elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child:  BlocConsumer<ReviewBloc, ReviewState>(
            listener: (context, state) {
          // TODO: implement listener
              print("Review state is ${state}");
        },
          builder: (context, state) {
            if(state is ReviewLoading) {
              return LoadingIcon();
            }
            if(state is ReviewCompleted){
              var review = state.review;
              var count  = state.review?.count;
              double avvgtotal = 0;
              for(int i =0 ;i<count! ;i ++) {
                avvgtotal= ((avvgtotal+ state!.review!.results![i].rating!)/2);
              }
              print(avvgtotal);

              return


                SizedBox.expand(

                  child: Column(
                    children: [
                      Container(
                          height:120,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [
                              // for(int index =0 ;index < state.review!.results!.length ; index ++)
                              // Text("${state.review!.results![index].rating}",style: TextStyle(
                              //     fontSize: 30
                              // ),),


                              Text("${review!.results![0].product?.avgRating?.toStringAsFixed(2)}",style: TextStyle(
                                  fontSize: 30
                              ),),
                              // for(int index =0 ;index < state.review!.results!.length ; index ++)
                              // Center(
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: liststar.map((e) {
                              //       return
                              //
                              //         Icon(Icons.star,size: 25,color:
                              //
                              //         state.review!.results![index].rating! > liststar.indexOf(e) ?
                              //         Color(0xff508A7B) :
                              //         Colors.grey
                              //           ,);
                              //     }).toList(),
                              //   ),
                              // ),

                              RatingBar.builder(
                                initialRating:double.parse(widget.star) ?? 0,
                                minRating: 1,
                                glowColor: Colors.green,


                                direction: Axis.horizontal,
                                allowHalfRating: true  ,



                                itemCount: 5,
                                tapOnlyMode: true ,
                                ignoreGestures: true  ,
                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Color(AppColorConfig.success),
                                ), onRatingUpdate: (double value) {


                              },

                                // onRatingUpdate: (rating) {
                                //   setState(() {
                                //     overall = rating.toInt();
                                //     print(overall);
                                //   });
                                // },
                              ),
                              SizedBox(height: 5,),
                              Text("Based on ${state.review?.results?.length} reviewer ",style: TextStyle(
                                  fontSize: 12.8
                              ),),
                            ],
                          )),
                      Divider(),
                      SizedBox(height: 10,),
                      Expanded(
                        child: ListView.builder(

                          itemCount: review?.results?.length ?? 0,

                          scrollDirection: Axis.vertical,

                          itemBuilder: (context, index) {


                            var reviews = state.review!.results![index];
                            return


                              CardReview(
                                review: reviews,


                              );
                          },),
                      ),
                    ],
                  ),
                );
            }
            if(state is ReviewError) {
              return Center(
                child: Text(state.error),
              );
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }

          },
        )
        ),
      ),
      bottomNavigationBar:            Container(
        margin: EdgeInsets.all(10),

    decoration: BoxDecoration(

    ),

    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [

    Expanded(
    child: ElevatedButton(

    onPressed: () {
      Navigator.push(context, MaterialPageRoute(

         fullscreenDialog: true,
        builder: (context) {
          return ReviewModify(
            productname: widget.pname,
            productimage:widget.pimage ,
            pid: widget.pid,
          );
      },));



    },
        
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.all(15),

    backgroundColor: Color(AppColorConfig.success),
    elevation: 0,
    
    shape: RoundedRectangleBorder(
    side: BorderSide(color: Colors.black.withOpacity(0.14)),
    borderRadius: BorderRadius.circular(3)
    )
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.edit_sharp,size: 20,),
      SizedBox(width: 5,),
      Text("Write A Review",style: TextStyle(
        fontSize: 14.8
      ),)

    ],
    )),
    ),
    ]
    ),
    ),
    );
  }
}

