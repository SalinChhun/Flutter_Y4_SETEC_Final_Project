import 'package:ecommerce/viewmodel/products/product_fav_bloc.dart';
import 'package:ecommerce/views/client/product/MyProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/Product/ProductModel.dart';
import '../../../res/constant/appcolor.dart';
import '../../widget/LoadingIcon.dart';
import '../../widget/Product/GridCardItem.dart';
import '../product/Product.dart';
import '../utilities/SearchPage.dart';
import 'package:lottie/lottie.dart';
class MyWishScreen extends StatefulWidget {
  var uid;
  MyWishScreen({Key? key,this.uid}) : super(key: key);

  @override
  State<MyWishScreen> createState() => _MyWishScreenState();
}

class _MyWishScreenState extends State<MyWishScreen> {


  @override
  void initState() {
    // TODO: implement initState


    super.initState();
  }

  Widget build(BuildContext context) {
    // print(widget.uid);
    context.read<ProductFavBloc>().add(ShowFavorite(widget.uid));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        toolbarHeight: MediaQuery
            .of(context)
            .size
            .width * 0.20,
        title: Text("My WishList", style: TextStyle(
            fontSize: 22,
            color: Colors.white
        ),),
        centerTitle: true,


        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.close, color: Colors.white),
        ),


        // CircleAvatar(
        //   radius: 20,
        //   backgroundImage: NetworkImage('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fHww&w=1000&q=80'),
        // ),
        backgroundColor: Colors.black,
        elevation: 0,

      ),
      body: SafeArea(

          child: Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 14),
            child: BlocConsumer<ProductFavBloc, ProductFavState>(
              listener: (context, state) {
                // TODO: implement listener
                print(state);
                if(state is ProductFavSuccess) {
                  context.read<ProductFavBloc>().add(ShowFavorite(widget.uid));
                }
                if(state is ProductByIdSuccess ) {
                  context.read<ProductFavBloc>().add(ShowFavorite(widget.uid));
                }
              },
              builder: (context, state) {
                if(state is ProductfavLoading) {
                  return LoadingIcon();
                }
                if(state is ProductfavDone){
                  var len ;
                  if(  state.productFavModel!.count! > 0) {
                   len = state.productFavModel?.results![0].products?.length;
                  }

                  print("Count is ${   state.productFavModel?.count}");



                return
                  state.productFavModel?.count == 0 ?
                    Center(

                      child: Padding(
                        padding: const EdgeInsets.only(top: 85),
                        child: Column(

                          children: [
                            Lottie.asset('assets/lotties/wishlist.json',

                            fit: BoxFit.contain
                            ),
                            Text('You have no favorite product yet',style: TextStyle(

                              color: Colors.grey
                            ),)

                          ],
                        ),
                      ),
                    ) :


                  ListView.builder(
                itemCount: len ?? 0,

                itemBuilder: (context, index) {
                  var product = state.productFavModel?.results![0].products![index];
                  return InkWell(
                    onTap: () {
                      print("Product id is");
                      print(product.id);


                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ProductDetailScreen(
                          userid: widget.uid,

                          productss: MyProductDetail(

                       id: product.id,



                          imgid: product.imgid,
                          price: product.price,
                          categoryid: product.category?.id,
                          attribution: product.attribution,
                          discount: product.discount,
                          avgRating: product.avgRating,
                          description: product.description,
                          sellRating: product.sellRating,
                          productname: product.productname,
                          stockqty: product.stockqty






                        )
                          ,);
                      },));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 140,

                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.withOpacity(0.2))
                        ),




                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network('${product!.imgid![0].images!}'),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),
                                    Container(
                                      width: 180,
                                      child: Text("${product.productname}",

                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,


                                        style: TextStyle(
                                            fontSize: 16,

                                            overflow: TextOverflow.ellipsis,


                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                    SizedBox(height: 5,),
                                    Text("\$ ${product.price}",style: TextStyle(
                                        fontSize: 17.8,
                                        color: Color(AppColorConfig.success),
                                        fontWeight: FontWeight.w500
                                    ),),
                                    SizedBox(height: 10,),
                                    Container(






                                        decoration: BoxDecoration(
                                            color  :    Color(AppColorConfig.negativelight),
                                            border: Border.all(color:  Color(AppColorConfig.negativecolor),
                                                width: 1
                                            )
                                        ),
                                        padding: EdgeInsets.all(4),
                                        width: 70,




                                        child: Text("${product.discount}% OFF",style: TextStyle(

                                          color: Color(AppColorConfig.negativecolor),
                                          // backgroundColor:    Color(AppColorConfig.negativelight)
                                        ),)),
                                  ],)


                              ],
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 10,right: 5),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Color(AppColorConfig.negativecolor),
                                child: Icon(Icons.favorite,color: Color(AppColorConfig.negativelight),size: 15,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },);
                }
               if(state is ProductfavError){
                  return Center(
                    child:Text("Sth has error"),
                  );
                }
                else{
                return Center(
                  child: CircularProgressIndicator(),
                );
                }

              },
            ),
          )
      ),
    );
  }


}
