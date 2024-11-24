import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/products/product_bloc.dart';
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
import '../../widget/Product/CustomCard.dart';

class NewArrivalSection extends StatefulWidget {
  const NewArrivalSection({
    super.key,
  });

  @override
  State<NewArrivalSection> createState() => _NewArrivalSectionState();
}

class _NewArrivalSectionState extends State<NewArrivalSection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<ProductBlocSorting>(context).add(SortProduct());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("Home screen ended");

    // BlocProvider.of<ProductBlocSorting>(context).close();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Expanded(
        child: BlocConsumer<ProductBlocSorting, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is ProductSortLoading) {
          return Center(child: LoadingIcon());
        }
        if (state is ProductSortCompleted) {
          var results = state.product?.results ?? [];
          var len = results.length;
          if (len == 0) {
            return Center(child: Text("No products available"));
          }
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: len,
            itemBuilder: (context, index) {
              return CustomCardList(product: results[index], len: len);
            },
          );
        }
        if (state is ProductSortError) {
          return Center(
            child: Text("Error has been occur"),
          );
        } else {
          return Center(
            child: Text("sth error"),
          );
        }
      },
    ));
  }
}
