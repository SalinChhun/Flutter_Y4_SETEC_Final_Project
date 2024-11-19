
import 'package:ecommerce/model/Product/CartModel.dart';
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/Review/review_bloc.dart';
import 'package:ecommerce/views/client/Review/ReviewList.dart';
import 'package:flutter/material.dart';

import '../../../model/Category/ProductCategory.dart';
import '../../../model/Product/ProductModel.dart';
import '../../../model/Review/ReviewModel.dart';
import '../../../viewmodel/cart/cart_bloc.dart';
import '../../order/Cart.dart';
import '../../order/Checkout.dart';
import '../../widget/LoadingIcon.dart';
import '../Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../NavScreen.dart';
import '../product/MyProduct.dart';
import 'Review.dart';
import 'ReviewModify.dart';



class ProductReviewPart extends StatefulWidget {
  var reviewrating;
  MyProductDetail? product;
  var star;

  Product? productv2;

  ProductReviewPart({
    super.key, this.product,
    this.productv2,
    this.star
  });


  @override
  State<ProductReviewPart> createState() => _ProductReviewPartState();
}

class _ProductReviewPartState extends State<ProductReviewPart> {
  var product;

  var starpoint ;
  var liststar =[];

  @override
  void initState() {

    if(widget.product == null) {
      product = widget.productv2;


      for(int i =0;i<5;i++) {
        liststar.add(i);
      }
    }
    else{
      product = widget.product;

      for(int i =0;i<5;i++) {
        liststar.add(i);
      }
    }
    context.read<ReviewBloc>().add(ReviewFetch(pid: product.id));
    starpoint =product!.avgRating!.roundToDouble();
    // TODO: implement initState
    super.initState();


  }



  Widget build(BuildContext context) {

    print(starpoint);
    return BlocConsumer<ReviewBloc, ReviewState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is ReviewPostCompleted) {
          liststar.clear();
          starpoint = 0;
          if(widget.product == null) {
            product = widget.productv2;


            for(int i =0;i<5;i++) {
              liststar.add(i);
            }
          }
          else{
            product = widget.product;

            for(int i =0;i<5;i++) {
              liststar.add(i);
            }
          }
          context.read<ReviewBloc>().add(ReviewFetch(pid: product.id));
          print(liststar.length);
          print("State is review completed");
        }
      },
      builder: (context, state) {
        if(state is ReviewLoading) {
          return LoadingIcon();
        }
        if(state is ReviewCompleted){
          var review = state.review;
          num avgstar = 0;

          var count  = state.review?.count ?? 0;
          if(count > 0) {
           avgstar = state.review?.results?[0].product?.avgRating ??  0;
          }
          starpoint = avgstar;


          print(review);
          print(avgstar);



          return


            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,


                    children: [
                      Text("Review",style: Theme.of(context).textTheme.displayMedium,),
                      // Text(" (${count} reviewers)",style: TextStyle(
                      //     fontSize: 12.6
                      // ),)
                    ],
                  ),
                  if(review?.results?.length != 0)

                    InkWell(
                      onTap: () {
                        print("Hello");
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ReviewModify(pid:product.id ,
                            productimage: product.imgid![0].images,
                            productname: product.productname,

                          );
                        },));
                      },
                      child:

                      Row(
                        children: [
                          InkWell(
                            onTap: () {

                            },
                            child: Icon(Icons.mode_edit_rounded,color: Colors.grey,size: 17,)  ,
                          ),
                          SizedBox(width: 5,),
                          Text("Write a review",style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.8,
                              color: Colors.grey
                          ),),
                        ],
                      ),
                    ),

                ],
              ),
              Divider(),
              SizedBox(height: 25,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(avgstar.toStringAsPrecision(3),style: TextStyle(
                          fontSize: 40
                      ),),
                      SizedBox(width: 5,),
                      Text("out of 5",style: TextStyle(
                          fontWeight: FontWeight.w400
                      ),),
                    ],
                  ),
                  Row(
                    children: liststar.map((e) {
                      return

                        Icon(Icons.star,size: 20,color:
                            
                        starpoint > liststar.indexOf(e) ?
                        Color(0xff508A7B) :
                        Colors.grey
                          ,);
                    }).toList(),
                  ),


                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("${count} reviews on this product",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.8,
                      color: Colors.grey
                  ),),
                  Row(
                    children: [

                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ReviewList(pid:product.id ,
                              pimage: product.imgid![0].images,
                              pname: product.productname,
                              star:avgstar.toStringAsPrecision(3)
                            );
                          },));

                        },
                        child:

                        Row(
                          children: [

                            if(review?.results?.length != 0)
                            Text("See More",style: TextStyle(
                                fontSize: 11,
                                color: Color(AppColorConfig.success)
                            ),),
                            if(review?.results?.length != 0)
                            Icon(Icons.navigate_next,size: 20,
                              color: Color(AppColorConfig.success),
                            )
                          ],
                        ),
                      ),
                      if(review?.results?.length == 0)

                        InkWell(
                          onTap: () {
                            print("On Press");
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ReviewModify(pid:product.id ,
                                productimage: product.imgid![0].images,
                                productname: product.productname,

                              );
                            },));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.mode_edit_rounded,color: Colors.grey,size: 17,),
                              SizedBox(width: 5,),
                              Text("Write a review",style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.8,
                                  color: Colors.grey
                              ),),
                            ],
                          ),
                        ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 25,),


              Container(
                height:   review?.results?.length  == 0  ? 100 : 330,
                child:

        ListView.builder(

                  itemCount: review?.results?.length ?? 0,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,

                  itemBuilder: (context, index) {


                    var reviews = state.review!.results![index];
                      return


                        CardReview(
                        review: reviews,


                      );
                },),
              ),
           


              SizedBox(height: 25,),
            ],
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
    );
  }
}

class CardReview extends StatefulWidget {

  Reviews? review;
   CardReview({
    super.key,this.review
  });

  @override
  State<CardReview> createState() => _CardReviewState();
}

class _CardReviewState extends State<CardReview> {
  var starpoint ;

  var liststar =[];

  @override
  void initState() {
    // TODO: implement initState
    starpoint = widget.review?.rating!.toDouble();
    for(int i=0;i<5;i++)
    liststar.add(i);
    super.initState();
  }
  String convertToAgo(DateTime input){
    Duration diff = DateTime.now().difference(input);

    if(diff.inDays >= 1){
      return '${diff.inDays} day ago';
    } else if(diff.inHours >= 1){
      return '${diff.inHours} hour ago';
    } else if(diff.inMinutes >= 1){
      return '${diff.inMinutes} minute ago';
    } else if (diff.inSeconds >= 1){
      return '${diff.inSeconds} seconds ago';
    } else {
      return 'just now';
    }
  }

  Widget build(BuildContext context) {

    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 10),
      color: Color(0xffEFF0F2),
      child: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading:  CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.withOpacity(0.33),
                backgroundImage: NetworkImage('${widget.review?.customer?.imgid?.images}'

                ),
              ),
              contentPadding: EdgeInsets.all(0),
              title : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.review?.customer?.username}',style: TextStyle(
                      fontSize: 12.8
                  ),),
                  Row(
                    children: liststar.map((e) {
                      return

                        Icon(Icons.star,size: 20,color:

                        starpoint > liststar.indexOf(e) ?
                        Color(0xff508A7B) :
                        Colors.grey
                          ,);
                    }).toList(),
                  ),
                ],
              ),

              trailing:    Text("${convertToAgo(DateTime.parse(widget.review!.updatedAt.toString()))}",style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.8,
                  color: Colors.grey
              ),),
            ),
            Text('${widget.review?.description}',

              style: TextStyle(
                  fontSize: 10.8,
                  color: Color(0xff666666),
                  fontWeight: FontWeight.w400
              ),
            )
          ],
        ),
      ),
    );
  }
}