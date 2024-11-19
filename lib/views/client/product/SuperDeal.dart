
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/products/product_bloc.dart';
import 'package:ecommerce/views/client/category/category.dart';
import 'package:ecommerce/views/client/utilities/searchscreen.dart';
import 'package:ecommerce/views/order/Cart.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../widget/LoadingIcon.dart';
import '../Home.dart';
import '../ProductAllScreen.dart';

class SuperDealList extends StatefulWidget {
  SuperDealList({
    super.key,
  });

  @override
  State<SuperDealList> createState() => _SuperDealListState();
}

class _SuperDealListState extends State<SuperDealList> {
  ProductBlocBestSell productbloc = ProductBlocBestSell();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();


  }
  Widget build(BuildContext context) {
    BlocProvider.of<ProductDiscountBloc>(context).add(DiscountProduct());
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(

        width: double.maxFinite,
        height: 290,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Super Deal",style:
                Theme.of(context).textTheme.labelLarge,),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return  SearchScreen(
                          sortby:2,
                          focus:false,
                        searchtitle: '',
                      );
                    },));
                  },
                  child: Text("See All",style:
                  Theme.of(context).textTheme.headlineSmall,),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Expanded(

              child: BlocConsumer<ProductDiscountBloc,ProductState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {

                  if(state is ProductLoadingDiscount) {
                    return Center(
                        child:LoadingIcon()

                    );
                  }
                  if(state is ProductDiscountCompleted) {
                    var productlen = state.product!.results!.length;
                    var allproduct = state.product!.results;
                    int len =  productlen;
                    return ListView.builder(

                      scrollDirection: Axis.horizontal,
                      itemCount:productlen ,
                      itemBuilder: (context, index) {

                        return   CardHoriScroll(product: allproduct![index],);
                      },);
                  }
                  if(state is ProductErrorDiscount){
                    return Center(
                      child: Text("Error has been occur"),
                    );
                  }
                  else{
                    return Center(
                      child: Text("Error has been occur"),
                    );
                  }

                },
              ),
            )


          ],
        ),
      ),
    );
  }
}