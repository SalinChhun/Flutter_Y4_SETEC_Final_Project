import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/views/client/product/Superdealscreen.dart';
import 'package:ecommerce/views/widget/LoadingIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../res/constant/appcolor.dart';
import '../../../viewmodel/Superdeal/special_deal_bloc.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({
    super.key,
  });

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  CarouselSliderController controller = CarouselSliderController();
  SpecialDealBloc specialDealBloc = SpecialDealBloc();
  var initindex = 0;

  @override
  void initState() {
    // TODO: implement initState
    context.read<SpecialDealBloc>().add(FetchDeal());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("Carousel stop using");
    context.read<SpecialDealBloc>().add(FetchDeal());
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print("Dependency called");

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<SpecialDealBloc, SpecialDealState>(
      listener: (context, state) {
        // TODO: implement listener
        print(state);
        print("My Super deal state ");
        if (state is ResetState) {
          context.read<SpecialDealBloc>().add(FetchDeal());
        }
      },
      builder: (context, state) {
        if (state is SepcialDealLoading) {
          return Center(child: LoadingIcon());
        }
        if (state is SepcialDealCompleted) {
          var deal = state.superDealModel?.results;
          var length = deal?.length ?? 0;

          // Add a null or empty check before rendering the carousel
          if (length == 0) {
            return Center(child: Text("No deals available"));
          }

          return Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.38,
            child: Column(
              children: [
                // ... existing carousel code ...

                // Only show CarouselIndicator if length > 0
                if (length > 0)
                  Center(
                    child: CarouselIndicator(
                      count: length,
                      index: initindex,
                      color: Colors.grey,
                      height: 10,
                      activeColor: Colors.black,
                      width: 10,
                    ),
                  ),
              ],
            ),
          );
        }
        if (state is SpecialDealError) {
          return Center(
            child: Text("Error ${state.errormessage} "),
          );
        } else {
          return LoadingIcon();
        }
      },
    );
  }
}
