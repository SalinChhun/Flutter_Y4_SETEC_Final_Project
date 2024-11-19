import 'package:ecommerce/res/appurl/appurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/Order/OrderDetail.dart';
import '../../../res/constant/appcolor.dart';
import '../../../viewmodel/Review/review_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlertReviewPop extends StatefulWidget {
  OrderList? orderList;

  AlertReviewPop({Key? key, this.orderList}) : super(key: key);

  @override
  State<AlertReviewPop> createState() => _AlertReviewPopState();
}

class _AlertReviewPopState extends State<AlertReviewPop> {
  var starlist = [0, 1, 2, 3, 4];
  var isselectstar = [false, false, false, false, false];
  var txtdesc = TextEditingController();
  var overall ;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewBloc, ReviewState>(
      listener: (context, state) {
        // TODO: implement listener}
        print("Myy State");
        print(state);
        if(state is ReviewPostCompleted) {
          // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //
          //       SnackBar(
          //         content: Text("Thanks you for your review"),
          //         backgroundColor: Color(AppColorConfig.success),
          //
          //
          //       ));
          //
          //
          //
          //
          //
          //   Navigator.pop(context);
          // });



        }

        if(state is ReviewPostLoading) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(

                SnackBar(
                  content: Text("Thanks you for your review"),
                  backgroundColor: Color(AppColorConfig.success),


                ));





            // Navigator.pop(context);
          });
          // showDialog(context: context, builder: (context) {
          //
          //
          //   return  Center(
          //
          //     child: CircularProgressIndicator(
          //       color: Color(AppColorConfig.bgcolor),
          //
          //     ),
          //   );
          //
          // },);
          //
          // Future.delayed(Duration(seconds: 2),() => Navigator.pop(context),);

        }
      },
      child:
      AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Rate Your Purchase", style: TextStyle(
                fontSize: 18,
                color: Color(AppColorConfig.success)
            ),),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },

                child: Icon(Icons.close,color: Color(AppColorConfig.success),))
          ],
        ),


        content: SingleChildScrollView(
          child: Container(
            height: 420,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                for(int index = 0; index < widget.orderList!.products!.length!; index++)
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                    decoration: BoxDecoration(
                      // color: Colors.grey.withOpacity(0.09)
                    ),
                    child:

                    ListTile(


                      contentPadding: EdgeInsets.all(0),
                      leading: Image.network(
                          '${ApiUrl.main}${widget.orderList?.products?[index]
                              .colorselection?.imgid?.images}'),

                      title: Text("${widget.orderList?.products?[index].product
                          ?.productname}", style: TextStyle(
                          fontSize: 12.8,
                          overflow: TextOverflow.ellipsis
                      ),),


                    ),
                  ),
                SizedBox(height: 20,),
                Text("Rating  ", style: TextStyle(
                    fontSize: 11.8,
                    color: Colors.black
                ),),
                RatingBar.builder(
                  initialRating:1,
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
                //           print(e);
                //           setState(() {
                //             isselectstar[e] = !isselectstar[e];
                //           });
                //         },
                //
                //
                //         child: Icon(Icons.star,
                //           size: 35,
                //           color:
                //           isselectstar[e] == true ?
                //           Colors.orange :
                //
                //           Colors.grey,));
                //   }).toList(),
                // ),


                SizedBox(height: 10,),
                Text("Write Your Review  ", style: TextStyle(
                    fontSize: 11.8,
                    color: Colors.black
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

                            color: Colors.grey.withOpacity(0.3)
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
            ),
          ),
        ),
        elevation: 0,
        actions: [
          ElevatedButton(

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


                // var ratingpoint = starp.length;
                print("Rating star is ${overall}");
                SharedPreferences prefs = await SharedPreferences
                    .getInstance();
                var userid = prefs.getInt("userid");
                print("Submit Review");
                print(widget.orderList!.products!.length!);


                for (int index = 0; index < widget.orderList!.products!.length; index++) {
                  print( widget.orderList?.products![index].product?.id,);
                  context.read<ReviewBloc>().add(ReviewPost(
                      pid: widget.orderList?.products![index].product?.id,
                      uid: userid,
                      desc: txtdesc.text,
                      rating: overall

                  ));
                }

                Navigator.pop(context);


              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(AppColorConfig.success),
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
                  Text("Submit", style: TextStyle(
                    fontSize: 12.8,

                  ),)
                ],
              ))
        ],
      ),
    );
  }
}
