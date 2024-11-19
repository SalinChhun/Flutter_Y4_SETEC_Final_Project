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

          return Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.38,
            child: Column(
              children: [
                //TODO
                Container(
                  decoration: BoxDecoration(
                      color: Color(AppColorConfig.primaryswatch),
                      borderRadius: BorderRadius.circular(10)),
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.28,
                  child: CarouselSlider.builder(
                    carouselController: controller,
                    itemCount: length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        InkWell(
                      onTap: () {
                        print(itemIndex);
                        print(deal?[itemIndex].product);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) {
                                return Superdealscreen(
                                  dealname: deal?[itemIndex].dealname,
                                  discount: deal?[itemIndex].discount,
                                  product: deal![itemIndex].product,
                                  dealid: deal[itemIndex].id,
                                );
                              },
                            ));
                      },
                      child: Container(
                        color: Color(AppColorConfig.primaryswatch),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${deal?[itemIndex].dealname}",
                                        style: TextStyle(
                                            fontSize: 12.9,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "${deal?[itemIndex].description}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            CachedNetworkImage(
                              // imageUrl: "https://fakeimg.pl/300x150?text=+",
                              imageUrl: deal![itemIndex].imgid!.images!,
                              width: 200,
                              height: 500,
                              fit: BoxFit.cover,

                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child: Image.network(
                                "https://fakeimg.pl/300x150?text=+",
                                fit: BoxFit.cover,
                              )),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),

                            // Image.network('${deal?[itemIndex].imgid?.images}',
                            //
                            // fit: BoxFit.cover,
                            //   width: 200,
                            //   height: double.maxFinite,
                            //
                            // ),
                          ],
                        ),
                      ),
                    ),
                    options: CarouselOptions(
                      height: 280,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.easeInOut,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      onPageChanged: (index, reason) {
                        setState(() {
                          initindex = index;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

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
