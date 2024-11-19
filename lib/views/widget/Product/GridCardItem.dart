import 'package:ecommerce/model/Product/ProductModel.dart';
import 'package:ecommerce/viewmodel/products/product_bloc.dart';
import 'package:ecommerce/views/ErrorPage.dart';
import 'package:ecommerce/views/widget/LoadingIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../res/constant/appcolor.dart';
import '../../client/ProductAllScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../client/product/MyProduct.dart';
import '../../client/product/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GridCardItem extends StatefulWidget {
  var iscroll ;
  var iswishlist ;
  GridCardItem({this.iscroll,this.iswishlist});


  @override
  State<GridCardItem> createState() => _GridCardItemState();


}

class _GridCardItemState extends State<GridCardItem> {
  var itemsize = 130;
  late ScrollController _controller;

var listsize = 0.0;
var initpage = 1;
var init = false;
var totalpage;
  List<Results> listofproduct =[];
  late ProductBloc filtersBloc;

  @override
  void initState() {

    filtersBloc = BlocProvider.of<ProductBloc>(context);
    filtersBloc.add(ClearAllState());
    listsize = 0.0;
    init = true;
    print("Clear everthing");
    initpage = 1;
    print("Discover init");
    listofproduct.clear();
    // TODO: implement initState


    // productbloc.add( FetchProduct());
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    super.initState();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    print("Stop close");
    listsize = 0.0;
    //
    // print("Clear everthing");
    initpage = 1;

    listofproduct.clear();
    // print(listofproduct.length);
    // BlocProvider.of<ProductBloc>(context).close();
    filtersBloc.add(ClearAllState());
    super.dispose();
  }
  void _scrollListener() {

    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      //todO pagination here
        print("Bottom");

          initpage ++;
          print(initpage);
        if(initpage > totalpage) {
            initpage--;
          return;
        }
        else{
          filtersBloc.add(FetchProduct(page: initpage ));
        }



    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {

        print("Top");

    }
  }
  Widget build(BuildContext context) {
    print("Discover rebuild");
    filtersBloc.add(FetchProduct(page: initpage));

    return
      widget.iswishlist == true ?
          Center(child: Text("Wish List"),) :

      BlocConsumer<ProductBloc,ProductState>(
      listener: (context, state) {
        // TODO: implement listener
        print(state);
      },
      builder: (context, state) {
        //
        if(state is ProductLoading) {
          return LoadingIcon();
        }
        if(state is ProductCompleted) {
          print(listofproduct.length);
          if(init == true) {
            print("Clear product in list ");
            listofproduct.clear();
            init = false;
          }
          // listofproduct.clear();
          totalpage = state.product?.totalPages ?? 0;
          print("Total Page ${totalpage}");

          var productlen = state.product!.results!.length;

          var allproduct = state.product!.results;
          // print(allproduct?.length);


          double len = productlen.toDouble();

          listsize = (len /2 ).floorToDouble() ;



          listofproduct.addAll(state.product!.results!);




          print(" product length is ${state.product!.results!.length}" );
          // if(listofproduct.length >state.product!.results! ){
          //
          // }



          print("Current product length is ${listofproduct.length}" );

          return Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(0),
            // height:
            //
            //
            //
            // productlen.isOdd ?  360 * (len -   listsize  ) :
            //
            // 360 * (len -   listsize  )
            //     ??  0,
            // //algrothims infinite scroll


            margin:
         widget.iscroll == null ?
            EdgeInsets.only(top: 20) :
         EdgeInsets.only(top: 0)
            ,
            child: Column(
              children: [
                if(widget.iscroll == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Keep Discover", style:
                    Theme
                        .of(context)
                        .textTheme
                        .labelLarge,),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //       return  ProductAllPage(apptitle: 'Discover',);
                    //     },));
                    //   },
                    //   child: Text("See All",style:
                    //   Theme.of(context).textTheme.headlineSmall,),
                    // ),
                  ],
                ),
                if(widget.iscroll == null)
                SizedBox(height: 20,),
                Expanded(

                  child: RefreshIndicator(
                    onRefresh: () {
                    print("Refresh");
                    listofproduct.clear();
                    initpage = 1;


                    BlocProvider.of<ProductBloc>(context).add(FetchProduct(page: 1));

                return TickerFuture.complete();
                    },
                    color: Colors.black,
                    child: GridView.builder(

                      controller: _controller,

                      physics:
                          widget.iscroll == true ?
                        AlwaysScrollableScrollPhysics() :

                        NeverScrollableScrollPhysics(),


                      itemCount: listofproduct.length,
                      scrollDirection: Axis.vertical,

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisExtent: 290,


                          childAspectRatio: 19 / 12,


                          mainAxisSpacing:5

                      ),
                      itemBuilder: (context, index) {



                        var product =  listofproduct![index];
                        return Container(
                          height: 430,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.35)
                            )
                          ),

                          child: InkWell(
                            onTap: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              
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
                                    productss: MyProductDetail(
                                        id: product!.id,
                                        imgid: product!.imgid,
                                        price: product!.price,
                                        categoryid:product!.category?.id,
                                        attribution:  product!.attribution,
                                        discount:  product!.discount,
                                        avgRating:  product!.avgRating,
                                        description: product!.description,
                                        sellRating: product!.sellRating,
                                        productname:  product!.productname,
                                        stockqty: product!.stockqty
                                    ));

                              },));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Stack(
                                    children: [
                                      CachedNetworkImage(
                                        // imageUrl: "http://via.placeholder.com/350x150",
                                        imageUrl:product!.imgid![0].images.toString(),
                                          width: double.maxFinite,
                                          height: 180,
                                        fit: BoxFit.cover,

                                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                                            Center(child:
                                            CircularProgressIndicator(
                                                color: Color(AppColorConfig.success),

                                                value: downloadProgress.progress)),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                      // Image.network('${product!.imgid![0].images} ',fit: BoxFit.cover,
                                      //
                                      //   width: double.maxFinite,
                                      //   height: 180,
                                      //
                                      //
                                      //
                                      // ),
                                      Positioned(
                                        top: 5,
                                        right: 0,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Row(
                                            children: [
                                              Icon(Icons.star, size: 20,
                                                color: Colors.amberAccent,),
                                              Text("${product.avgRating!.toStringAsFixed(2)}", style: TextStyle(

                                              ),)
                                            ],
                                          ),
                                        ),
                                      )

                                    ],


                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      if(product.discount !=0 )
                                      Container(


                                          decoration: BoxDecoration(
                                              color: Color(
                                                  AppColorConfig.negativelight),
                                              border: Border.all(color: Color(
                                                  AppColorConfig.negativecolor),
                                                  width: 1
                                              )
                                          ),
                                          padding: EdgeInsets.all(4),
                                          width: 70,


                                          child:

                                          Text("${product.discount } % ", style: TextStyle(


                                            color: Color(
                                                AppColorConfig.negativecolor),
                                            fontSize: 12.8
                                            // backgroundColor:    Color(AppColorConfig.negativelight)
                                          ),)),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text("${product.sellRating} sold", style: TextStyle(
                                            fontSize: 12.8,
                                            color: Color(AppColorConfig.success)
                                        ),),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8, top: 9),
                                    child: Text("${product.productname}", style: TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.only(left: 8,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text("\$ ${product.price}", style: TextStyle(
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
                                            backgroundColor: Color(
                                                AppColorConfig.success),
                                            radius: 12,


                                            child: Image.asset(
                                              'assets/logo/shopping-cart.png',
                                              fit: BoxFit.cover,
                                              width: 14,
                                              height: 14,
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
                      },

                    ),
                  ),
                ),


              ],
            ),
          );
        }
        if(state is ProductError){

          return const ErrorPage();
        }
        else {
          return LoadingIcon();
        }


      },
    );
  }
}