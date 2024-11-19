

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../model/Product/ProductModel.dart';
import '../../../res/constant/appcolor.dart';
import '../../client/product/MyProduct.dart';
import '../../client/product/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CustomCardList extends StatefulWidget {
  Results? product;
  var len;
CustomCardList(  {
    super.key,
  this.product,
  this.len
  });

  @override
  State<CustomCardList> createState() => _CustomCardListState();
}

class _CustomCardListState extends State<CustomCardList> {

  @override

  Widget build(BuildContext context) {
    print("My images in custom card are");
    print(widget.product!.imgid![0].images);
    return InkWell(
      onTap: () async {

        SharedPreferences prefs= await SharedPreferences.getInstance();
        Navigator.push(context,MaterialPageRoute(builder: (context) {


          return ProductDetailScreen(
            userid: prefs.getInt("userid"),
              productss: MyProductDetail(
                  id: widget.product!.id,
                  imgid: widget.product!.imgid,
                  price: widget.product!.price,
                  categoryid:widget.product!.category?.id,
                  attribution:  widget.product!.attribution,
                  discount:  widget.product!.discount,
                  avgRating:  widget.product!.avgRating,
                  description:  widget.product!.description,
                  sellRating:  widget.product!.sellRating,
                  productname:  widget.product!.productname,
                  stockqty:  widget.product!.stockqty
              ));

        },));
      },
      child: Container(


        margin: EdgeInsets.only(bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.24)
            )
          ),



          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //TODO image card here

              Expanded(

                child:
                CachedNetworkImage(
                  // imageUrl: "http://via.placeholder.com/350x150",
                  imageUrl: widget.product!.imgid![0].images.toString(),
                  width: double.maxFinite,
                  height: 155,
                  fit: BoxFit.cover,

                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(child:
                      CircularProgressIndicator(
                          color: Color(AppColorConfig.success),

                          value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),

              ),

              Expanded(

                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      if(widget.product?.discount != 0)
                      Container(





                          decoration: BoxDecoration(
                              color  :    Color(AppColorConfig.negativelight),
                              border: Border.all(color:  Color(AppColorConfig.negativecolor),
                                  width: 1
                              )
                          ),
                          padding: EdgeInsets.all(4),
                          width: 70,




                          child: Text("${widget.product?.discount}% OFF",style: TextStyle(

                            color: Color(AppColorConfig.negativecolor),
                            // backgroundColor:    Color(AppColorConfig.negativelight)
                          ),)),


                      if(widget.product?.discount == 0)
                        SizedBox(height: 40,),
                      //TODO title product
                      Row(

                        children: [
                          Expanded(
                            child: Text("${widget.product!.productname}",style: TextStyle(
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w400
                            ),),
                          ),
                          // Expanded(
                          //   child: Row(
                          //     children: [
                          //       Icon(Icons.star,size: 20,color: Colors.amberAccent,),
                          //       Text("4.5",style: TextStyle(
                          //
                          //         ),)
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                      //TODO title product
                      Container(
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("\$ ${widget.product!.price! - ( widget.product!.price! * (double.parse(widget.product!.discount!.toString() )/100)).truncateToDouble() }",style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20

                            ),),



                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 10),

                              decoration: BoxDecoration(

                                shape: BoxShape.circle,

                              ),
                              child: CircleAvatar(
                                backgroundColor:      Color(AppColorConfig.success),
                                radius: 12,


                                child: Image.asset('assets/logo/shopping-cart.png',fit: BoxFit.cover,
                                  width: 14,
                                  height: 14,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Free Shipping",style: TextStyle(
                              fontSize: 10.8,
                              fontWeight: FontWeight.w400,
                            color: Color(AppColorConfig.success)
                          ),),

                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                Icon(Icons.star,size: 20,color: Colors.amberAccent,),
                                Text("${widget.product!.avgRating!.toStringAsFixed(2)}",style: TextStyle(

                                ),)
                              ],
                            ),
                          )
                        ],
                      ),



                    ],
                  ),
                ),
              )


              //TODO detail card here

            ],
          ),


        ),
      ),
    );
  }
}