import 'package:ecommerce/model/Product/CartModel.dart';
import 'package:ecommerce/res/appurl/appurl.dart';
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/Review/review_bloc.dart';
import 'package:ecommerce/viewmodel/products/product_fav_bloc.dart';
import 'package:ecommerce/views/authentication/Require.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../helper/HexColorConverter.dart';
import '../../../model/Category/ProductCategory.dart';
import '../../../model/Product/ProductModel.dart';
import '../../../viewmodel/cart/cart_bloc.dart';
import '../../../viewmodel/category/category_bloc.dart';
import '../../../viewmodel/products/product_bloc.dart';
import '../../order/Cart.dart';
import '../Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../NavScreen.dart';
import '../Review/Review.dart';
import 'MyProduct.dart';

class ProductDetailScreen extends StatefulWidget {
  Results? product;
  Product? productv2;
  MyProductDetail? productss;
  var userid;
  var bothproduct;
  var avgrating;
  var isorderview;

  ProductDetailScreen(
      {Key? key,
      this.product,
      this.productv2,
      this.bothproduct,
      this.productss,
      this.userid,
      this.avgrating,
      this.isorderview})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var imgindexx = 0;
  var selectedindex = 0;
  var islogin = false;
  var token;
  var isfav;

  var click = false;
  MyProductDetail? allproduct;
  // var allproduct;
  Product? allproduct2;

  var isfavorite = false;

  @override
  void initState() {
    print("Product is is ${widget.productss?.id}");
    // TODO: implement initState
    super.initState();
    context
        .read<ProductFavBloc>()
        .add(ProductById(widget.userid, widget.productss?.id));

    checktoken();
  }

  onChangeimage(Context, index) {
    print(index);
    print("Click on Images");
    setState(() {});
  }

  onReviewUpate(Context) {
    setState(() {
      print("Excute again");
    });
  }

  void PopUpUnauthorize(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Login or Register",
            style:
                TextStyle(fontSize: 18, color: Color(AppColorConfig.success)),
          ),
          content: Text(
            "Require to login first before you can make an order",
            style: TextStyle(
                fontSize: 12.8,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
          elevation: 0,
          actions: [
            ElevatedButton(
                onPressed: () {
                  print('press press');
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) {
                      return RequireLoginandSignup();
                    },
                  ), (route) => false);
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
                        fontSize: 12.8,
                      ),
                    )
                  ],
                ))
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    allproduct = widget.productss;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<ProductFavBloc, ProductFavState>(
        listener: (context, state) {
          print(state);
          // TODO: implement listener
          print(state);
          if (state is ProductFavSuccess) {
            context
                .read<ProductFavBloc>()
                .add(ProductById(widget.userid, widget.productss?.id));
          }
          if (state is ProductByIdSuccess) {
            if (state.productFavModel?.count != 0) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  isfavorite = true;
                });
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  isfavorite = false;
                });
              });
            }
          }
        },
        child: BlocBuilder<ProductFavBloc, ProductFavState>(
          builder: (context, state) {
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    elevation: 0,
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    expandedHeight: 400,
                    flexibleSpace: CachedNetworkImage(
                      imageUrl: widget.isorderview == true
                          ? '${ApiUrl.main}${allproduct!.imgid![imgindexx].images}'
                          : '${allproduct!.imgid![imgindexx].images}',
                      // imageUrl: deal![itemIndex].imgid!.images!,
                      height: double.maxFinite,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: Color(AppColorConfig.primarycolor),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.8),
                          child: IconButton(
                            icon: Icon(
                              isfavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Color(0xffFF6E6E),
                            ),
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              setState(() {
                                isfavorite
                                    ? context.read<ProductFavBloc>().add(
                                        RemoveFavorite(prefs.getInt("userid"),
                                            allproduct?.id))
                                    : context.read<ProductFavBloc>().add(
                                        AddFavorite(prefs.getInt("userid"),
                                            allproduct?.id));
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name and Price Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  allproduct?.productname ?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(112, 16, 223, 100),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (allproduct?.discount != 0)
                                      Text(
                                        '\$ ${allproduct?.price?.toStringAsFixed(2) ?? ''}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.white,
                                        ),
                                      ),
                                    Text(
                                      '\$ ${(allproduct?.price ?? 0.0 - (allproduct?.price ?? 0.0 * (double.parse(allproduct?.discount?.toString() ?? '0') / 100))).toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16),

                          // Rating and Sales Info
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.orange, size: 20),
                                  SizedBox(width: 4),
                                  Text(
                                    "${allproduct!.avgRating!.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${allproduct!.sellRating} sold",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(AppColorConfig.primarycolor),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16),

                          // Discount Tag
                          if (allproduct?.discount != 0)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "\% ${allproduct?.discount} off",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xffF04438),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                          // Rest of the existing widgets remain the same
                          //TODO available section color

                          DetailSizeColor(
                            vieworder: widget.isorderview,
                            attributes: allproduct?.attribution,
                            images: allproduct?.imgid,
                            function: onChangeimage,
                            stock: allproduct?.stockqty,
                          ),

                          //TODO available Product Detail
                          ProductDetailSection(
                            vieworder: true,
                            desc: allproduct?.description,
                            attribution: allproduct?.attribution,
                          ),

                          //TODO review section here
                          ProductReviewPart(
                              product: widget.productss,
                              star: allproduct!.avgRating!.toStringAsFixed(2)),

                          SizedBox(
                            height: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BlocConsumer<CartBloc, AllCart>(
        listener: (context, state) {
          // TODO: implement listener
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            width: 240,
            duration: Duration(milliseconds: 500),
            content: Container(
              height: 50,
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,

              //color: Colors.white,
              decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(width: 0, color: Colors.black),
                  borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Added to Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            behavior: SnackBarBehavior.floating,
          ));
        },
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              elevation: 0,
                              backgroundColor: Colors.white,
                              builder: (context) {
                                return FractionallySizedBox(
                                  heightFactor: 0.9,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: SingleChildScrollView(
                                      child: DetailSizeColor(
                                        attributes: allproduct?.attribution,
                                        isview: true,
                                        images: allproduct!.imgid,
                                        function: onChangeimage,
                                        product: allproduct!,
                                        vieworder: widget.isorderview,
                                        price: allproduct!.price,
                                        iscart: true,
                                        stock: allproduct!.stockqty,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(AppColorConfig.primarycolor),
                            elevation: 0,
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.black.withOpacity(0.14)),
                                borderRadius: BorderRadius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/logo/shopping-cart.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                                color: Colors.white),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Add to Cart",
                              style: TextStyle(
                                  fontSize: 14.8, color: Colors.white),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          if (token != null) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            print("User id is ");
                            print(prefs.getInt('userid'));

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
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: EdgeInsets.all(15),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.black.withOpacity(0.14)),
                                borderRadius: BorderRadius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Check Out",
                              style: TextStyle(
                                  fontSize: 14.8, color: Colors.white),
                            )
                          ],
                        )),
                  ),
                ]),
          );
        },
      ),
    ); // Existing bottom navigation bar code
  }

  void checktoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
  }
}

class DetailSizeColor extends StatefulWidget {
  var attributes;
  var product;

  var price;
  // List<Imgid>? images;
  var images;
  Function? function;
  var iscart;
  var vieworder;
  var stock;
  var isview;
  DetailSizeColor({
    super.key,
    this.product,
    this.isview,
    this.vieworder,
    this.attributes,
    this.images,
    this.function,
    this.stock,
    this.iscart,
    this.price,
  });

  @override
  State<DetailSizeColor> createState() => _DetailSizeColorState();
}

class _DetailSizeColorState extends State<DetailSizeColor> {
  var isselectedimg;
  var attri;
  var imgindexx = 0;
  var discount = 0;

  var sizeindex = 0;
  @override
  Widget build(BuildContext context) {
    print("Discount");
    // print(widget.product.discount );
    //
    print("state update");
    print(attri?.colorid![imgindexx].imgid?.images);

    attri = widget.attributes;
    if (widget?.product?.discount == null) {
      discount == 0;
    } else {
      discount = widget?.product?.discount;
    }
    print(discount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.iscart != null)
          CachedNetworkImage(
            imageUrl: widget.vieworder == true
                ? '${ApiUrl.main}${attri?.colorid![imgindexx].imgid?.images}'
                : '${attri?.colorid![imgindexx].imgid?.images}',
            // imageUrl: deal![itemIndex].imgid!.images!,

            width: double.maxFinite,
            height: 200,
            fit: BoxFit.contain,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: Image.network(
              "https://fakeimg.pl/300x150?text=+",
              fit: BoxFit.cover,
            )),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        SizedBox(
          height: 10,
        ),
        if (widget.iscart != null)
          SizedBox(
            height: 20,
          ),
        if (widget.price != null)
          if (widget?.product?.discount != null)
            Text(
              "\$ ${(attri?.colorid![imgindexx].price! - (attri?.colorid![imgindexx].price! * (double.parse(widget.product.discount.toString()) / 100))).toStringAsFixed(2)}",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Color(AppColorConfig.primarycolor)),
            ),
        if (widget.price != null)
          discount > 0
              ? Row(
                  children: [
                    Text(
                      "\$ ${attri?.colorid![imgindexx].price}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          decoration:
                              discount > 0 ? TextDecoration.lineThrough : null,
                          color: Color(AppColorConfig.negativecolor)),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      "% ${discount}",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(AppColorConfig.negativecolor)),
                    ),
                  ],
                )
              : Text(""),
        SizedBox(
          height: 20,
        ),
        if (widget.isview != null)
          Text(
            "Stock : ${widget.stock == 0 ? 'Out of Stock ' : attri?.colorid![imgindexx].stockqty}",
            style: widget.stock == 0
                ? TextStyle(
                    color: Color(AppColorConfig.negativecolor),
                    fontSize: 16,
                    fontWeight: FontWeight.w500)
                : Theme.of(context).textTheme.displayMedium,
          ),
        SizedBox(
          height: 10,
        ),
        Text(
            "${attri?.colorid?.length ?? 0}  Color, ${attri?.size?.length ?? 0} Size",
            style: TextStyle(fontSize: 12.7)),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              "Available Color:",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                width: double.maxFinite,
                height: 25,
                child: ListView.builder(
                  itemCount: attri?.colorid.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // final Color color = HexColor.fromHex('#aabbcc');
                    Color colorcode = HexColor(attri?.colorid[index].code);

                    return InkWell(
                      onTap: () {
                        setState(() {
                          imgindexx = index;
                        });
                        print(imgindexx);
                      },
                      child: Container(
                        width: 25,
                        margin: EdgeInsets.only(right: 5),
                        height: 25,
                        // child: Text(attri?.colorid[index].code),
                        decoration: BoxDecoration(
                            color: colorcode,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                color: imgindexx == index
                                    ? Color(AppColorConfig.primarycolor)
                                    : Colors.grey.withOpacity(0.45))),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: List.generate(attri?.colorid?.length ?? 0, (index) {
            var imglink = attri?.colorid?[index].imgid?.images;
            // print(imglink);
            return Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    imgindexx = index;
                  });
                },
                child: Container(
                  width: 140,
                  height: 140,
                  margin: EdgeInsets.only(right: 7),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      style: BorderStyle.solid,
                      color: imgindexx == index
                          ? Color(AppColorConfig.primarycolor)
                          : Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(
                        20.0), // Adjust the radius as needed
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        18.0), // Adjust the radius as needed
                    child: CachedNetworkImage(
                      imageUrl: widget.vieworder == true
                          ? '${ApiUrl.main}${imglink}'
                          : '${imglink}',
                      fit: BoxFit.cover,
                      width: double.maxFinite,
                      height: 200,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: Image.network(
                          "https://fakeimg.pl/300x150?text=+",
                          fit: BoxFit.cover,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          "Choose size: ${attri?.size![sizeindex].size}",
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Color(AppColorConfig.primarycolor),
              ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.maxFinite,
          height: 30,
          child: ListView.builder(
            itemCount: attri?.size?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var size = attri?.size;
              return InkWell(
                onTap: () {
                  setState(() {
                    sizeindex = index;
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: sizeindex == index
                        ? const Color.fromRGBO(112, 16, 223, 100)
                            .withOpacity(0.4)
                        : Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text("${size![index].size}"),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 40,
        ),
        if (widget.iscart != null)
          ElevatedButton(
              onPressed: () {
                print("The attributes is ${attri}");

                if (attri?.colorid![imgindexx].stockqty == 0) {
                  return;
                }

                context.read<CartBloc>().add(CartToAdd(
                    cartitem: CartItem(
                        attribution: attri,
                        cartid: DateTime.now(),
                        stockqty: attri?.colorid![imgindexx].stockqty,
                        discount: widget.product?.discount ?? 0,
                        qty: 1,
                        productid: widget.product!.id,
                        imgurl: attri.colorid![imgindexx].imgid?.images,
                        colorid: attri.colorid![imgindexx],
                        price: double.parse((attri?.colorid![imgindexx].price! -
                                (attri?.colorid![imgindexx].price! *
                                    (double.parse(discount.toString()) / 100)))
                            .toStringAsFixed(2)),

                        // attri?.colorid![imgindexx].price,
                        producttitle: widget.product!.productname,
                        sizeid: attri.size![sizeindex].id,
                        sizetext: attri.size![sizeindex].size)));

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: attri?.colorid![imgindexx].stockqty == 0
                    ? Color(AppColorConfig.negativecolor)
                    : Color(AppColorConfig.primarycolor),
                elevation: 0,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo/shopping-cart.png',
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                      color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    attri?.colorid![imgindexx].stockqty == 0
                        ? "Out of Stock"
                        : "Add to Cart",
                    style: TextStyle(fontSize: 14.8, color: Colors.white),
                  )
                ],
              )),
      ],
    );
  }
}

class ProductDetailSection extends StatefulWidget {
  var desc;
  var attribution;
  var vieworder;
  AttributionCategory? attributionv2;
  ProductDetailSection(
      {super.key,
      this.vieworder,
      this.desc,
      this.attribution,
      this.attributionv2});

  @override
  State<ProductDetailSection> createState() => _ProductDetailSectionState();
}

class _ProductDetailSectionState extends State<ProductDetailSection> {
  var attri;
  @override
  Widget build(BuildContext context) {
    if (widget?.attribution == null) {
      attri = widget.attributionv2;
    } else {
      attri = widget.attribution;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "${widget?.desc}",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        SizedBox(
          height: 10,
        ),

        //TODO Product Detail section color
        Text(
          "Product Detail",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Divider(),
        Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Material"),
                Text(
                  "${attri?.materialName}",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Weight"),
                Text(
                  "${attri?.weight}",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Model"),
                Text(
                  "${attri?.model}",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
