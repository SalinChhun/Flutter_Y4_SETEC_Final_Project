import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/products/product_bloc.dart';
import 'package:ecommerce/views/client/category/category.dart';
import 'package:ecommerce/views/client/utilities/searchscreen.dart';
import 'package:ecommerce/views/order/Cart.dart';
import 'package:ecommerce/views/widget/LoadingIcon.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Home.dart';
import '../ProductAllScreen.dart';


class PopularSection extends StatefulWidget {
  PopularSection({
    super.key,
  });

  @override
  State<PopularSection> createState() => _PopularSectionState();
}

class _PopularSectionState extends State<PopularSection> {
  ProductBlocBestSell productbloc = ProductBlocBestSell();
  @override
  void initState() {
    // TODO: implement initState
    context.read<ProductBlocBestRating>().add(SortProduct(rank: "DESC",sortname: "popular"));
    super.initState();


  }
  Widget build(BuildContext context) {

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
                Text("Most Popular ",style:
                Theme.of(context).textTheme.labelLarge,),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return  SearchScreen(
                          sortby:1,
                          focus:false,
                        searchtitle: "",
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

              child: BlocConsumer<ProductBlocBestRating,ProductState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {

                  if(state is ProductLoading) {
                    return Center(
                        child:LoadingIcon()

                    );
                  }
                  if(state is ProductCompleted) {
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