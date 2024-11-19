import 'package:ecommerce/views/widget/LoadingIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/Product/SuperdealModel.dart';
import '../../../res/constant/appcolor.dart';
import '../../../viewmodel/Superdeal/special_deal_bloc.dart';
import '../../widget/Product/GridCardItem.dart';
import '../utilities/SearchPage.dart';
import 'MyProduct.dart';
import 'Product.dart';

class Superdealscreen extends StatefulWidget {

  List<Product?>? product;
  var dealname;
  var discount;
  var dealid;

  Superdealscreen(
      {Key? key, this.product, this.dealname, this.discount, this.dealid})
      : super(key: key);

  @override
  State<Superdealscreen> createState() => _SuperdealscreenState();
}

class _SuperdealscreenState extends State<Superdealscreen> {

  SpecialDealBloc specialDealBloc = SpecialDealBloc(); // Initialize your bloc

  @override
  void initState() {
    // TODO: implement initState
    context.read<SpecialDealBloc>().add(FetchById(widget.dealid));
    print("deal is ${widget.dealid}");

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("Dispose called");
    specialDealBloc.add(ClearState());
    super.dispose();
  }


  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<SpecialDealBloc>().add(FetchDeal());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery
              .of(context)
              .size
              .width * 0.20,
          title: BlocConsumer<SpecialDealBloc, SpecialDealState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if(state is SepcialDealByIdCompleted ) {
                return Text("${state.superDealSingle?.dealname}", style: TextStyle(
                    fontSize: 22,
                    color: Colors.white
                ),);
              }
              else {
                return Text("${widget.dealname}", style: TextStyle(
                    fontSize: 22,
                    color: Colors.white
                ),);
              }

            },
          ),
          titleSpacing: 0,
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          leading: InkWell(
            onTap: () {
              context.read<SpecialDealBloc>().add(ClearState());
            },
            child: Icon(
                Icons.clear
            ),
          ),

          backgroundColor: Colors.black,
          elevation: 0,

        ),
        body: SafeArea(


          child: BlocConsumer<SpecialDealBloc, SpecialDealState>(
            listener: (context, state) {
              print("Super screen staate is ");
              // TODO: implement listener
              print(state);
              if (state is ResetState) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.pop(context);
                });
              }
              if (state is SepcialDealByIdLoading) {
                LoadingIcon();
              }
            },
            builder: (context, state) {
              if (state is SepcialDealByIdCompleted) {
                return GridView.builder(


                  physics:

                  AlwaysScrollableScrollPhysics(),

                  itemCount: widget.product?.length ?? 0,
                  scrollDirection: Axis.vertical,

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisExtent: 290,


                      childAspectRatio: 19 / 12,


                      mainAxisSpacing: 5

                  ),
                  itemBuilder: (context, index) {
                    var product = state.superDealSingle?.product?[index];

                    return Container(
                      height: 430,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.35)
                          )
                      ),

                      child: InkWell(
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences
                              .getInstance();

                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ProductDetailScreen(
                                  userid: prefs.getInt("userid"),
                                  productss: MyProductDetail(
                                    id: product!.id,
                                    imgid: product!.imgid,
                                    price: product!.price,

                                    categoryid: product!.category?.id,
                                    attribution: product!.attribution,
                                    discount: product!.discount,
                                    avgRating: product!.avgRating,
                                    description: product!.description,
                                    sellRating: product!.sellRating,
                                    productname: product!.productname,
                                    stockqty: product!.stockqty,

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

                                  Image.network('${product?.imgid?[0].images}',
                                    fit: BoxFit.cover,
                                    width: double.maxFinite,
                                    height: 180,


                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 0,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.star, size: 20,
                                            color: Colors.amberAccent,),
                                          Text("${product?.avgRating
                                              ?.roundToDouble()}",
                                            style: TextStyle(

                                            ),)
                                        ],
                                      ),
                                    ),
                                  )

                                ],


                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  if(product?.discount != 0 )
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

                                        Text("${product?.discount } % ",
                                          style: TextStyle(


                                              color: Color(
                                                  AppColorConfig.negativecolor),
                                              fontSize: 12.8
                                            // backgroundColor:    Color(AppColorConfig.negativelight)
                                          ),)),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text("${product?.sellRating} sold",
                                      style: TextStyle(
                                          fontSize: 12.8,
                                          color: Color(AppColorConfig.success)
                                      ),),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 9),
                                child: Text(
                                  "${product?.productname}", style: TextStyle(
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
                                    Text(
                                      "\$ ${product?.price}", style: TextStyle(
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

                );
              }
              else {
                return LoadingIcon();
              }
            },
          ),
        ),
      ),
    );
  }


}
