import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/cart/cart_bloc.dart';
import 'package:ecommerce/views/client/product/MyProduct.dart';
import 'package:ecommerce/views/client/product/NewArrival.dart';
import 'package:ecommerce/views/client/product/BestSelling.dart';
import 'package:ecommerce/views/client/product/Popular.dart';
import 'package:ecommerce/views/client/product/Product.dart';
import 'package:ecommerce/views/client/product/SuperDeal.dart';
import 'package:ecommerce/views/client/profile/MyWishList.dart';
import 'package:ecommerce/views/client/utilities/SearchPage.dart';
import 'package:ecommerce/views/client/utilities/searchscreen.dart';
import 'package:ecommerce/views/order/Cart.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../model/Product/ProductModel.dart';
import '../../viewmodel/Superdeal/special_deal_bloc.dart';
import '../../viewmodel/category/category_bloc.dart';
import '../ErrorPage.dart';
import '../authentication/Login/LoginScreen.dart';
import '../widget/Product/CustomCard.dart';
import '../widget/Product/GridCardItem.dart';
import 'ProductAllScreen.dart';
import 'Review/ReviewPopUp.dart';
import 'SuperDeal/Customdealcarousel.dart';
import 'category/categoryscroll.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomeScreen extends StatefulWidget {
  var log;

  MyHomeScreen({Key? key, this.log}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {


  var islogin = false;
  var token;

  var txtdesc = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    print("Home Init state");

    super.initState();
    CheckAuthorize();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }


  Widget build(BuildContext context) {
    // TODO: implement build
    print("State rebuild");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery
            .of(context)
            .size
            .width * 0.20,
        title: Text("Explore", style: TextStyle(
            fontSize: 22,
            color: Colors.black
        ),),


        // CircleAvatar(
        //   radius: 20,
        //   backgroundImage: NetworkImage('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fHww&w=1000&q=80'),
        // ),
        backgroundColor: Colors.white.withOpacity(0.34),
        elevation: 0,

        actions: [
          //TODO search bar and profile cary

          InkWell(
            onTap: () {
              if (token != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CartScreen();
                },));
              }
              if (token == null) {
                PopUpUnauthorize(context);
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.black
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  BlocConsumer<CartBloc, AllCart>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return CircleAvatar(
                        backgroundColor: Colors.white,


                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            badges.Badge(
                              badgeContent: Text(
                                "${state?.itemcart?.length ?? 0}",
                                style: TextStyle(
                                    color: Colors.white
                                ),),
                              child: Image.asset('assets/logo/shopping-bag.png',
                                fit: BoxFit.cover,
                                width: 25,
                                height: 25,

                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  ),

                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (token != null) {
                SharedPreferences prefs = await SharedPreferences.getInstance();


                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyWishScreen(uid: prefs.getInt("userid"),);
                },));
              }
              if (token == null) {
                PopUpUnauthorize(context);
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 10),

              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Color(AppColorConfig.negativecolor),
                  border: Border.all(
                    color: Color(AppColorConfig.negativecolor),
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  BlocConsumer<CartBloc, AllCart>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return CircleAvatar(
                          backgroundColor: Color(AppColorConfig.negativelight),


                          child: Icon(Icons.favorite, color: Color(
                              AppColorConfig.negativecolor),)
                      );
                    },
                  ),

                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage(
                  titlesearch: "",
                  focus: true,
                );
              },));
            },
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.black
                  )
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,


                child: Icon(Icons.search_rounded, color: Colors.black,),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: BlocListener<CategoryBloc, CategoryState>(
                listener: (context, state) {
                  // TODO: implement listener}

                  if(state is CategoryError) {
                    const  ErrorPage();
                  }

                },
                child: Padding(
                  padding: const EdgeInsets.all(12.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      //TODO search bar

                      // Container(
                      //   height: 50,
                      //
                      //   width: double.maxFinite,
                      //   margin: EdgeInsets.only(bottom: 5),
                      //   child: TextField(
                      //
                      //     style: TextStyle(
                      //         fontSize: 13
                      //     ),
                      //
                      //     onTap: () {
                      //
                      //         Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //           return  SearchScreen();
                      //         },));
                      //
                      //     },
                      //
                      //     onSubmitted: (value) {
                      //       setState(() {
                      //
                      //       });
                      //     },
                      //     readOnly: true,
                      //     decoration: InputDecoration(
                      //       contentPadding: EdgeInsets.all(0),
                      //         filled: true,
                      //         hintText:'What are you looking for?',
                      //         prefixIcon: Icon(Icons.search_sharp,color: Colors.black,size: 22,),
                      //
                      //
                      //         fillColor: Color(AppColorConfig.bgfill),
                      //
                      //         floatingLabelStyle: TextStyle(
                      //             color: Colors.black
                      //         ),
                      //         border: OutlineInputBorder(
                      //             borderSide: BorderSide.none,
                      //             borderRadius: BorderRadius.circular(10)
                      //         )
                      //     ),
                      //
                      //   ),
                      // ),
                      //TODO caategory part
                      CustomCarousel(),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            //TODO bar search here
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Categories", style:
                                Theme
                                    .of(context)
                                    .textTheme
                                    .labelLarge,),

                              ],
                            ),
                            SizedBox(height: 20,),


                            //TODO cate tempalte card

                            Container(
                                width: double.maxFinite,
                                height: 150,

                                child: CardCategoryScroll())

                          ],
                        ),
                      ),
                      //TODO carousel part


                      //TODO list Special here
                      Container(
                        width: double.maxFinite,
                        height: 540,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("New Arrival", style:
                                Theme
                                    .of(context)
                                    .textTheme
                                    .labelLarge,),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return SearchScreen(
                                            sortby: 6,
                                            focus: false,
                                            searchtitle: '',
                                          );
                                        },));
                                  },
                                  child: Text("See All", style:
                                  Theme
                                      .of(context)
                                      .textTheme
                                      .headlineSmall,),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),

                            NewArrivalSection(


                            )
                          ],
                        ),
                      ),

                      //TODO section ratiing
                      BestSellingSection(),

                      //TODO section popular
                      PopularSection(),
                      //TODO section popular
                      SuperDealList(),
                      //TODO section all
                      // GridCardItem(),


                    ],
                  ),
                ),
              ),
            );
          },

        ),
      ),

    );
  }

  void CheckAuthorize() async {
    print("print user id ");
    SharedPreferences? prefs = await SharedPreferences.getInstance();

    prefs.getInt("userid");
    prefs.getBool("islogin");
    islogin = prefs.getBool("islogin") ?? false;
    print(prefs!.getInt("userid"));
    token = prefs.getString("token");
  }

  void PopUpUnauthorize(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        // backgroundColor: Color(AppColorConfig.primarylight),
        title: Text("Login or Register", style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color(AppColorConfig.success),
        ),),
        content: Text("Require to login first before you can make an order",
          style: TextStyle(
            fontSize: 12.8,
            fontWeight: FontWeight.w400,

            color: Color(AppColorConfig.success),
          ),),
        elevation: 0,
        actions: [
          ElevatedButton(

              onPressed: () {
                // Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return loginScreen();
                },));
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
                  Text("Login", style: TextStyle(
                      fontSize: 14.8,
                      color: Color(AppColorConfig.primarylight)

                  ),)
                ],
              ))
        ],
      );
    },);
  }


  closeform(BuildContext context) {
    Navigator.pop(context);
  }
}


class CardHoriScroll extends StatefulWidget {
  Results? product;

  CardHoriScroll({
    super.key,
    this.product
  });

  @override
  State<CardHoriScroll> createState() => _CardHoriScrollState();
}

class _CardHoriScrollState extends State<CardHoriScroll> {
  @override

  Widget build(BuildContext context) {

    print(widget.product!.imgid![0].images);

    return Container(

      width: 160,
      height: 70,
      margin: EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey.withOpacity(0.24)
          )
      ),
      child: InkWell(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                productss: MyProductDetail(
                    id: widget.product!.id,
                    imgid: widget.product!.imgid,
                    price: widget.product!.price,
                    categoryid: widget.product!.category?.id,
                    attribution: widget.product!.attribution,
                    discount: widget.product!.discount,
                    avgRating: widget.product!.avgRating,
                    description: widget.product!.description,
                    sellRating: widget.product!.sellRating,
                    productname: widget.product!.productname,
                    stockqty: widget.product!.stockqty
                ));
          },));
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Container(
                height: 125,
                child: Stack(
                  children: [

                    CachedNetworkImage(
                      // imageUrl: "http://via.placeholder.com/350x150",
                      imageUrl: widget.product!.imgid![0].images.toString(),
                      width: double.maxFinite,
                      height: double.maxFinite,
                      fit: BoxFit.cover,

                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Center(child:
                          CircularProgressIndicator(
                            color: Color(AppColorConfig.success),

                              value: downloadProgress.progress)),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    Positioned(
                      top: 5,
                      right: 0,
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star, size: 20, color: Colors.amberAccent,),
                            Text("${widget.product!.avgRating!.toStringAsFixed(
                                2)}", style: TextStyle(

                            ),)
                          ],
                        ),
                      ),
                    ),
                    if(widget.product!.discount != 0 )
                      Positioned(
                        left: 0,
                        top: 0,
                        child:

                        Container(


                            decoration: BoxDecoration(
                                color: Color(AppColorConfig.negativelight),
                                border: Border.all(
                                    color: Color(AppColorConfig.negativecolor),
                                    width: 1
                                )
                            ),
                            padding: EdgeInsets.all(4),
                            width: 43,


                            child: Text("${widget.product!.discount} % ",
                              style: TextStyle(

                                color: Color(AppColorConfig.negativecolor),
                                // backgroundColor:    Color(AppColorConfig.negativelight)
                              ),)),
                      ),

                  ],


                ),
              ),

              SizedBox(height: 5,),
              Text(" ${widget.product!.sellRating} sold", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.7,
                  color: Color(AppColorConfig.success)

              ),),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 9),
                child: Text("${widget.product!.productname}",

                  maxLines: 1,
                  style:

                  TextStyle(
                      fontSize: 14.8,
                      overflow: TextOverflow.ellipsis,

                      fontWeight: FontWeight.w400
                  ),),
              ),

              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$ ${widget.product!.price}", style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20

                    ),),


                    // Container(
                    //   alignment: Alignment.center,
                    //   margin: EdgeInsets.only(right: 10),
                    //
                    //   decoration: BoxDecoration(
                    //
                    //     shape: BoxShape.circle,
                    //
                    //   ),
                    //   child: CircleAvatar(
                    //     backgroundColor:      Color(AppColorConfig.success),
                    //     radius: 12,
                    //
                    //
                    //     child: Image.asset('assets/logo/shopping-cart.png',fit: BoxFit.cover,
                    //       width: 14,
                    //       height: 14,
                    //     ),
                    //   ),
                    // ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}





