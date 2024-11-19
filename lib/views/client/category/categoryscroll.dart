
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/category/category_bloc.dart';
import 'package:ecommerce/viewmodel/products/product_bloc.dart';
import 'package:ecommerce/views/ErrorPage.dart';
import 'package:ecommerce/views/client/ProductAllScreen.dart';
import 'package:ecommerce/views/client/category/category.dart';
import 'package:ecommerce/views/client/product/BestSelling.dart';
import 'package:ecommerce/views/client/utilities/searchscreen.dart';
import 'package:ecommerce/views/order/Cart.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../widget/LoadingIcon.dart';

class CardCategoryScroll extends StatefulWidget{
  CardCategoryScroll();

  @override
  State<CardCategoryScroll> createState() => _CardCategoryScrollState();
}

class _CardCategoryScrollState extends State<CardCategoryScroll> {
  CarouselController buttonCarouselController = CarouselController();
  @override
  void initState() {
    // TODO: implement initState
    context.read<CategoryBloc>().add(FetchCategory());
    super.initState();


  }
  Widget build(BuildContext context) {
    // TODO: implement build

    return BlocConsumer<CategoryBloc, CategoryState>(
  listener: (context, state) {
    // TODO: implement listener
    print(state);
    if (state is CategoryByidCompleted) {
      // Do nothing
      print("true");



    }
  },
  builder: (context, state) {
    if(state is CategoryLoading){
      return const LoadingIcon();
    }
    if(state is CategoryCompleted ){
      var len = state.category!.results!.length;

      return ListView.builder(
        itemCount: len ?? 0,

        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var category =  state.category!.results![index];
          return InkWell(
             onTap: () {
               print(category.id);
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProductAllPage(
                    category:  state.category!.results,
                    selectedcategory:  category.id,

                  );
               },));
             },
            child: Container(
              margin: EdgeInsets.only(right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //TODO image here
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade300,

                    backgroundImage:
                    NetworkImage('${category.imgid!.images}'),
                  ),


                  SizedBox(height: 10,),

                  Text("${category.categoryname}",style: TextStyle(
                    fontSize: 12.8
                  ),)
                ],
              ),
            ),
          );
        },);
    }
    if(state is CategoryError){
      return ErrorPage();
    }
    else{
      return Center(child: LoadingIcon());
    }

  },
);
  }
}
