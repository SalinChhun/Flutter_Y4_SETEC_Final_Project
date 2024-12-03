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
        toolbarHeight: MediaQuery.of(context).size.width * 0.20,
        title: Text(
          "Explore",
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
        backgroundColor: Colors.white.withOpacity(0.34),
        elevation: 0,
        actions: [
          //TODO search bar and profile cary

          InkWell(
            onTap: () {
              if (token != null) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return CartScreen();
                  },
                ));
              }
              if (token == null) {
                PopUpUnauthorize(context);
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black)),
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
                                style: TextStyle(color: Colors.white),
                              ),
                              child: Image.asset(
                                'assets/logo/shopping-bag.png',
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

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return MyWishScreen(
                      uid: prefs.getInt("userid"),
                    );
                  },
                ));
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
                  )),
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
                          child: Icon(
                            Icons.favorite,
                            color: Color(AppColorConfig.negativecolor),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return SearchPage(
                    titlesearch: "",
                    focus: true,
                  );
                },
              ));
            },
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black)),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.search_rounded,
                  color: Colors.black,
                ),
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

                  if (state is CategoryError) {
                    const ErrorPage();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                                Text(
                                  "Categories",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),

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
                        height: 580,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "New Arrival",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return SearchScreen(
                                          sortby: 6,
                                          focus: false,
                                          searchtitle: '',
                                        );
                                      },
                                    ));
                                  },
                                  child: Text(
                                    "See All",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          color: Color(AppColorConfig
                                              .primarycolor), // Change this to your desired color
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            NewArrivalSection()
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
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // backgroundColor: Color(AppColorConfig.primarylight),
          title: Text(
            "Login or Register",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(AppColorConfig.success),
            ),
          ),
          content: Text(
            "Require to login first before you can make an order",
            style: TextStyle(
              fontSize: 12.8,
              fontWeight: FontWeight.w400,
              color: Color(AppColorConfig.success),
            ),
          ),
          elevation: 0,
          actions: [
            ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context);

                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return loginScreen();
                    },
                  ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppColorConfig.success),
                    elevation: 0,
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black.withOpacity(0.14)),
                        borderRadius: BorderRadius.circular(3))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 14.8,
                          color: Color(AppColorConfig.primarylight)),
                    )
                  ],
                ))
          ],
        );
      },
    );
  }

  closeform(BuildContext context) {
    Navigator.pop(context);
  }
}

class CardHoriScroll extends StatefulWidget {
  Results? product;

  CardHoriScroll({super.key, this.product});

  @override
  State<CardHoriScroll> createState() => _CardHoriScrollState();
}

class _CardHoriScrollState extends State<CardHoriScroll> {
  String? getFirstImageUrl() {
    if (widget.product?.imgid == null || widget.product!.imgid!.isEmpty) {
      return null;
    }
    return widget.product!.imgid![0].images;
  }

  double calculateDiscountedPrice() {
    if (widget.product?.price == null || widget.product?.discount == null) {
      return 0.0;
    }
    final price = widget.product!.price!;
    final discount = widget.product!.discount!;
    return price - (price * (discount / 100)).truncateToDouble();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = getFirstImageUrl() ?? 'http://via.placeholder.com/350x150';
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (!mounted) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
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
                  stockqty: widget.product!.stockqty,
                ),
              ),
            ),
          );
        },
        child: Container(
          width: 180,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image and Badges Section
              Container(
                height: 144,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  fit: StackFit.passthrough,
                  clipBehavior: Clip.hardEdge,
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 144,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(AppColorConfig.success),
                            value: downloadProgress.progress,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[100],
                          child: const Icon(Icons.error_outline,
                              color: Colors.grey),
                        ),
                      ),
                    ),

                    // Discount Badge
                    if (widget.product!.discount != 0)
                      Positioned(
                        left: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(AppColorConfig.negativecolor)
                                .withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "-${widget.product!.discount}%",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                    // Rating Badge
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.product!.avgRating?.toStringAsFixed(1) ??
                                  "0.0",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Product Info Section
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      widget.product!.productname ?? "",
                      maxLines: 1, // Set to 1 to limit to a single line
                      overflow: TextOverflow
                          .ellipsis, // Show ellipsis if the text overflows
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Price and Discount
                    Row(
                      children: [
                        Text(
                          "\$${calculateDiscountedPrice().toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(AppColorConfig.primarycolor),
                          ),
                        ),
                        if (widget.product!.discount != 0) ...[
                          const SizedBox(width: 8),
                          Text(
                            "\$${widget.product!.price}",
                            style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Sales Count
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color:
                            Color(AppColorConfig.primarycolor).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${widget.product!.sellRating} sold",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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
