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
import '../../../viewmodel/products/product_bloc.dart';
import '../../order/Cart.dart';
import '../../order/Checkout.dart';
import '../Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../NavScreen.dart';
import 'Review.dart';


class ReviewModify extends StatefulWidget {
  var pid;
  var productname;
  var productimage;
  var overall;

  ReviewModify({this.pid, this.productname, this.productimage});

  @override
  State<ReviewModify> createState() => _ReviewModifyState();
}

class _ReviewModifyState extends State<ReviewModify> {
  var product;
  var overall;

  var txtdesc = TextEditingController();

  var starlist = [0, 1, 2, 3, 4];
  var selectstar = 0;
  var isselectstar = [false, false, false, false, false];
  late ProductBloc filtersBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.pid);
    print(widget.productname);
  }

  void PopUpUnauthorize(BuildContext context,String? message,String? header) {

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("${header}",style: TextStyle(
            fontSize: 18,
            color: Color(AppColorConfig.success)
        ),),
        content: Text("${message}",style: TextStyle(
            fontSize: 12.8,
            fontWeight: FontWeight.w400,

            color: Colors.black
        ),),
        elevation: 0,
        actions: [
          ElevatedButton(

              onPressed: () {

                Navigator.pop(context);


              },
              style: ElevatedButton.styleFrom(
                  backgroundColor:Color(AppColorConfig.success),
                  elevation: 0,
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black.withOpacity(0.14)),
                      borderRadius: BorderRadius.circular(3)
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(width: 10,),
                  Text("Dismiss",style: TextStyle(
                    fontSize: 12.8,

                  ),)
                ],
              ))
        ],
      );
    },);
  }
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

          title: Text("Write a Review", style: TextStyle(
              color: Colors.black
          ),),
          centerTitle: true,
          titleSpacing: 0,
          iconTheme: IconThemeData(
              color: Colors.black
          ),
          // centerTitle: true,
          backgroundColor: Colors.white,

          elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocListener<ReviewBloc, ReviewState>(
            listener: (context, state) {
              // TODO: implement listener}
              print("Review state is");
              print(state);
              
              if(state is ReviewPostLoading) {
                showDialog(context: context, builder: (context) {


                  return  Center(

                    child: CircularProgressIndicator(
                      color: Color(AppColorConfig.bgcolor),

                    ),
                  );

                },);
                Future.delayed(Duration(seconds: 2),() => Navigator.pop(context) ,);
              }
              if(state is ReviewPostCompleted) {


                context.read<ReviewBloc>().add(ReviewFetch(pid: widget.pid  ));
                context.read<ProductBlocBestSell>().add(SortProduct(rank: "DESC",sortname: "best_selling"));
                context.read<ProductBlocBestRating>().add(SortProduct(rank: "DESC",sortname: "popular"));
                BlocProvider.of<ProductDiscountBloc>(context).add(DiscountProduct());
                BlocProvider.of<ProductBlocSorting>(context).add (SortProduct());
                // context.read<ProductBloc>().add(FetchProduct(page: 1));
                //
                // filtersBloc = BlocProvider.of<ProductBloc>(context);
                // filtersBloc.add(ClearAllState());
                // filtersBloc.add(FetchProduct(page: 1));
                // filtersBloc.add(ClearAllState());
                Navigator.pop(context);

              }
              if(state is ReviewPostErrorMessage) {
                context.read<ReviewBloc>().add(ReviewFetch(pid: widget.pid  ));
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    PopUpUnauthorize(context,state.message,"Something went wrong");
                  });
                context.read<ReviewBloc>().add(ReviewFetch(pid: widget.pid  ));
              }
            },
            child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.09)
                      ),
                      child: ListTile(


                        contentPadding: EdgeInsets.all(0),
                        leading: Image.network('${widget.productimage}'),

                        title: Text("${widget.productname}"),


                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("Rating", style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),),
                    SizedBox(height: 10,),
                    Text("On a scale from 1 to 5 do your recommend this?",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.8
                      ),),
                    SizedBox(height: 20,),

                    RatingBar.builder(
                      initialRating:0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,



                      itemCount: starlist?.length ?? 0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          overall = rating.toInt();
                          print(overall);
                        });
                      },
                    ),
                    // Row(
                    //   children: starlist.map((e) {
                    //     return InkWell(
                    //         onTap: () {
                    //           // print(e);
                    //           setState(() {
                    //             selectstar = starlist.indexOf(e);
                    //             print(selectstar);
                    //             print(e);
                    //
                    //             if(isselectstar[e] == true) {
                    //               print("True");
                    //
                    //
                    //              isselectstar[e] =! isselectstar[e];
                    //
                    //              if(e == 4) {
                    //
                    //              }
                    //              else{
                    //                if(  isselectstar[e+1] == true) {
                    //                  isselectstar[e] = true;
                    //                }
                    //              }
                    //
                    //
                    //                     // if( isselectstar[e-1] == true) {
                    //                     //   return;
                    //                     // }
                    //
                    //
                    //
                    //
                    //
                    //
                    //               // for(int i = 0;i<=e;i++) {
                    //               //   print(isselectstar[i]);
                    //               //   print(i);
                    //               //   isselectstar[e] =! isselectstar[e];
                    //               //
                    //               //
                    //               //   // if(   isselectstar[i] == true) {
                    //               //   //   isselectstar[i] =false;
                    //               //   //   continue;
                    //               //   // }
                    //               //   // else{
                    //               //   //   isselectstar[i] = true;
                    //               //   // }
                    //               //
                    //               //
                    //               //
                    //               //
                    //               //
                    //               //
                    //               //
                    //               //
                    //               // }
                    //             }
                    //             else{
                    //               for(int i = 0;i<=selectstar;i++) {
                    //                 print(isselectstar[i]);
                    //                 print(i);
                    //                 // isselectstar[i] = !   isselectstar[i] ;
                    //
                    //                 //
                    //                 // if(   isselectstar[i] == true) {
                    //                 //   isselectstar[i] =false;
                    //                 //   return;
                    //                 //
                    //                 // }
                    //                 //
                    //                   isselectstar[i] = true;
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    //               }
                    //             }
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    //           });
                    //         },
                    //
                    //
                    //         child: Icon(Icons.star, color:
                    //         isselectstar[e] == true ?
                    //         Colors.orange :
                    //
                    //         Colors.grey,));
                    //   }).toList(),
                    // ),

                    SizedBox(height: 20,),

                    Text("Product Review", style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),),
                    SizedBox(height: 10,),

                    TextFormField(

                      cursorColor: Colors.grey,
                      style: TextStyle(
                          fontSize: 12.8,
                          color: Colors.black
                      ),

                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      maxLines: 4,
                      controller: txtdesc,
                      onSaved: (newValue) {
                        setState(() {
                          txtdesc.text = newValue.toString();
                        });
                      },


                      decoration: InputDecoration(
                          fillColor: Colors.grey.withOpacity(0.03),
                          filled: true,
                          hintText: "Your opinion about this product",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(

                                color: Colors.grey
                            ),
                            borderRadius: BorderRadius.circular(4),

                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.3)
                              )

                          )
                      ),
                    )
                  ],
                )
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10),

        decoration: BoxDecoration(

        ),

        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Expanded(
                child: ElevatedButton(

                    onPressed: () async {
                      // var starpoint = isselectstar.map((e) => e == true)
                      //     .toList();
                      //
                      // var starp = [];
                      // starpoint.forEach((element) {
                      //   if (element == true) {
                      //     starp.add(element);
                      //   }
                      // });
                      //
                      //
                      // var ratingpoint = starp.length;
                      print("Rating star is ${overall}");
                      SharedPreferences prefs = await SharedPreferences
                          .getInstance();
                      var userid = prefs.getInt("userid");
                      print(userid);
                      print(txtdesc.text);
                      print(widget.pid);
                      if(overall == null || overall == '' || txtdesc.text == '') {

                        showDialog(context: context, builder: (context) {


                          return  Center(

                            child: CircularProgressIndicator(
                              color: Color(AppColorConfig.bgcolor),

                            ),
                          );

                        },);

                        Future.delayed(Duration(seconds: 2),() {

                          Navigator.pop(context);


                        },);
                        PopUpUnauthorize(context,'Don\'t leave your rating star or description blank',"Missing Information");


                        return;
                      }
                      context.read<ReviewBloc>().add(ReviewPost(
                          pid: widget.pid,
                          uid: userid,
                          desc: txtdesc.text,
                          rating: overall

                      ));

                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //
                      // },));


                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(AppColorConfig.success),
                        elevation: 0,
                        padding: EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.black.withOpacity(0.14)),
                            borderRadius: BorderRadius.circular(3)
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit_sharp, size: 18,),
                        SizedBox(width: 5,),
                        Text("Submit Review", style: TextStyle(
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

