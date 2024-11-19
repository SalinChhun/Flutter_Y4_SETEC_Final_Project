import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/category/category_bloc.dart';
import 'package:ecommerce/views/ErrorPage.dart';
import 'package:ecommerce/views/client/product/MyProduct.dart';
import 'package:ecommerce/views/client/product/Product.dart';
import 'package:ecommerce/views/client/utilities/SearchPage.dart';
import 'package:ecommerce/views/client/utilities/searchscreen.dart';
import 'package:ecommerce/views/widget/LoadingIcon.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/Category/CategoryModel.dart';
import '../widget/Product/GridCardItem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ProductAllPage extends StatefulWidget {
  var apptitle;
  List<Results>? category;
  var selectedcategory ;
 ProductAllPage({Key? key,this.apptitle,this.category,this.selectedcategory }) : super(key: key);

  @override
  State<ProductAllPage> createState() => _ProductAllPageState();
}

// var sortclass = [
//   "Best Selling",
//   "New Arrival",
//   "Rating",
//   "Name A-z",
//   "Name z-A",
//   "Price",
//   "Filter",
//   "Sort"
// ];
class _ProductAllPageState extends State<ProductAllPage> {
  var txtsearch = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    print(widget.selectedcategory );
    // http://127.0.0.1:8000/product/sort?search=Men&popular=asc

    super.initState();
  }

    Widget build(BuildContext context) {
      // TODO: implement build
      BlocProvider.of<CategoryBlocProduct>(context).add(FetchCategoryProduct(categoryid:widget.selectedcategory ));
      return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Container(
            alignment: Alignment.center,
            height: 40,

            child: TextField(
              style: TextStyle(

                  fontSize: 13
              ),
              cursorColor: Colors.grey,

              readOnly: true,


              onSubmitted: (value) {
                setState(() {
                  txtsearch.text = value;
                });


              },

              onTap: () {
                Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) {
                  // return  SearchScreen(
                  //   sortby: 0,
                  //   focus: true,
                  //
                  // );
                  return SearchPage(focus: true,
                  titlesearch: txtsearch.text,

                  );
                },


                ),
                  (route) => true,
                );
              },

              decoration: InputDecoration(
                  // filled: true,
                  //
                  // fillColor: Color(AppColorConfig.bgfill),
                  hintText: 'Search By brand or product name...etc',
                  contentPadding: EdgeInsets.only(right: 24),


                  floatingLabelStyle: TextStyle(
                      color: Colors.black
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)
                  )
              ),

            ),
          ),
          // title:Text("${widget.apptitle}",style: TextStyle(
          //     color: Colors.black
          // ),),
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0.14),
          centerTitle: true,

          actions: [
            // InkWell(
            //     onTap: () {
            //       Navigator.push(context,MaterialPageRoute(builder: (context) {
            //         return  SearchScreen();
            //       },));
            //
            //     },
            //
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Icon(Icons.search),
            //     ))
          ],

        ),
        body: SafeArea(
          child:
        Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     //TODO sort section
            //
            //     ElevatedButton(
            //         onPressed:() {
            //
            //         },
            //         style: ElevatedButton.styleFrom(
            //             backgroundColor: Colors.white,
            //             elevation: 0,
            //             shape: RoundedRectangleBorder(
            //                 side: BorderSide(
            //                     color: Colors.black.withOpacity(0.06)
            //                 )
            //             ),
            //
            //
            //             padding: EdgeInsets.only(top: 1.7,bottom: 1.7,left: 70,right: 70)
            //         ),
            //
            //
            //         child: Column(
            //           children: [
            //             Icon(Icons.sort,
            //               color: Colors.grey,
            //             ),
            //             Text("Sort By",style: TextStyle(
            //                 fontSize: 12.8,
            //                 color: Colors.grey
            //             ),)
            //           ],
            //         )
            //
            //     ),
            //     SizedBox(width: 10,),
            //     ElevatedButton(
            //         onPressed:() {
            //
            //         },
            //         style: ElevatedButton.styleFrom(
            //             backgroundColor: Colors.white,
            //             elevation: 0,
            //             shape: RoundedRectangleBorder(
            //                 side: BorderSide(
            //                     color: Colors.black.withOpacity(0.06)
            //                 )
            //             ),
            //
            //
            //             padding: EdgeInsets.only(top: 1.7,bottom: 1.7,left: 70,right: 70)
            //         ),
            //
            //
            //         child: Column(
            //           children: [
            //             Icon(Icons.filter_list,
            //               color: Colors.grey,
            //             ),
            //             Text("Filter",style: TextStyle(
            //                 fontSize: 12.8,
            //                 color: Colors.grey
            //             ),)
            //           ],
            //         )
            //
            //     ),
            //   ],
            // ),

            // Text("10 Products Found",style: TextStyle(
            //   fontSize: 12.8,
            //   color: Colors.black,
            //   fontWeight: FontWeight.w400
            // ),),
            //TODO show filter here

            Container(
                width: double.maxFinite,
                height: 39,

                child:       ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.category?.length ?? 0,
                  itemBuilder: (context, index) {

                    return InkWell(
                      onTap: () {
                        context.read<CategoryBlocProduct>().add(FetchCategoryProduct(
                            categoryid: widget.category![index].id));
                        print(widget.category![index].id);
                        setState(() {
                          widget.selectedcategory = widget.category![index].id;
                        });


                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color:
                            widget.selectedcategory ==  widget.category![index].id ?
                            Color(AppColorConfig.success) :
                            null
                            ,
                            border:
                            widget.selectedcategory ==  widget.category![index].id ?
                            Border.all(color: Colors.green) :
                            Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(6)
                        ),
                        margin: EdgeInsets.only(right: 20),

                        child: Row(
                          children: [
                            Icon(Icons.filter_list,size: 19,

                              color: widget.selectedcategory ==  widget.category![index].id ?
                              Color(AppColorConfig.primarylight)  :
                              null ,
                            ),
                            Text("${ widget.category?[index].categoryname}",
                              style: TextStyle(
                                  fontSize: 12.8,
                                  color:
                                  widget.selectedcategory ==  widget.category![index].id ?
                                  Color(AppColorConfig.primarylight)  :
                                  null
                              ),
                            ),
                          ],
                        ),


                      ),
                    );
                  },)

            ),

            SizedBox(height: 10,),



            Expanded(

              child: BlocConsumer<CategoryBlocProduct, CategoryState>(
  listener: (context, state) {
    // TODO: implement listener
    print("Category stae is ${state}");
  },
  builder: (context, state) {
    if(state is CategoryByidLoading){
      return const  Center(
        child:LoadingIcon(),
      );
    }
    if(state is CategoryByidCompleted){

      return
        state.product?.product?.length != 0 ?
        GridView.builder(
        // physics: NeverScrollableScrollPhysics(),



        itemCount: state.product?.product?.length ?? 0,
        scrollDirection: Axis.vertical,

        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3,
            mainAxisExtent: 310,


            childAspectRatio: 19 / 12,



            mainAxisSpacing: 5

        ),

        itemBuilder:(context, index) {
          var product = state.product?.product![index];

          return InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductDetailScreen(
                    userid: prefs.getInt("userid"),
                    productss: MyProductDetail(

                        id: product!.id,
                        imgid: product!.imgid,


                        price: product!.price,
                        categoryid:product!.category?.id,
                        attribution: product!.attribution,
                        discount:  product!.discount,

                        avgRating: product!.avgRating,

                        description:  product!.description,
                        sellRating: product!.sellRating,
                        productname: product!.productname,
                        stockqty: product!.stockqty
                    ));
              },));
            },
            child: Container(
              height: 300,
              child: Card(
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Stack(
                      children: [
                        Image.network('${state.product?.product![index].imgid![0].images}',

                        fit: BoxFit.contain,
                          width: double.maxFinite,
                          height: 170,

                        ),
                        Positioned(
                          top: 5,
                          right: 0,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                Icon(Icons.star,size: 20,color: Colors.amberAccent,),
                                Text("${product!.avgRating!.roundToDouble() }",style: TextStyle(

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
                        Container(





                            decoration: BoxDecoration(
                                color  :    Color(AppColorConfig.negativelight),
                                border: Border.all(color:  Color(AppColorConfig.negativecolor),
                                    width: 1
                                )
                            ),
                            padding: EdgeInsets.all(4),
                            width: 70,




                            child:

                            Text("50% OFF",style: TextStyle(

                              color: Color(AppColorConfig.negativecolor),
                              // backgroundColor:    Color(AppColorConfig.negativelight)
                            ),)),
                        Text("${product.sellRating} sold",style: TextStyle(
                            fontSize: 12.8,
                            color: Color(AppColorConfig.success)
                        ),)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8,top: 9),
                      child: Text("${product.productname}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,


                        style: TextStyle(
                          fontSize: 16,

                          fontWeight: FontWeight.w500
                      ),),
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("\$ ${product.price}",style: TextStyle(
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

                  ],
                ),
              ),
            ),
          );
        },

      ) :
      Center(
        child: Text("No items found"),
      );
    }
    if(state is CategoryByidError){
      return ErrorPage();
    }

    return Center(
      child: const LoadingIcon()
    );

  },
),
            ),

          ],
        ),
      )
          

        ),
      );
    }
}
