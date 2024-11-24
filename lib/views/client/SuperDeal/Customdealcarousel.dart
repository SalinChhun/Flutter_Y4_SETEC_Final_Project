import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../res/constant/appcolor.dart';
import '../../../viewmodel/Superdeal/special_deal_bloc.dart';
import '../../widget/LoadingIcon.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({Key? key}) : super(key: key);

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;
  SpecialDealBloc? _specialDealBloc;

  @override
  void initState() {
    super.initState();
    _specialDealBloc = context.read<SpecialDealBloc>();
    _specialDealBloc?.add(FetchDeal());
  }

  @override
  void dispose() {
    _specialDealBloc = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SpecialDealBloc, SpecialDealState>(
      listener: (context, state) {
        if (state is ResetState) {
          context.read<SpecialDealBloc>().add(FetchDeal());
        }
      },
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildCarouselContent(state),
        );
      },
    );
  }

  Widget _buildCarouselContent(SpecialDealState state) {
    if (state is SepcialDealLoading) {
      return const Center(child: LoadingIcon());
    }

    if (state is SepcialDealCompleted) {
      final deals = state.superDealModel?.results;
      if (deals == null || deals.isEmpty) {
        return const Center(
          child: Text(
            "No deals available",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        );
      }

      return _buildCarousel(deals);
    }

    if (state is SpecialDealError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              "Error: ${state.errormessage}",
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return const LoadingIcon();
  }

  Widget _buildCarousel(List<dynamic> deals) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.38,
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider.builder(
              carouselController: CarouselSliderController(),
              itemCount: deals.length,
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: deals.length > 1,
                reverse: false,
                autoPlay: deals.length > 1,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  if (mounted) {
                    setState(() {
                      _currentIndex = index;
                    });
                  }
                },
              ),
              itemBuilder: (context, index, realIndex) {
                final deal = deals[index];
                return _buildCarouselItem(deal);
              },
            ),
          ),
          const SizedBox(height: 16),
          if (deals.length > 1)
            CarouselIndicator(
              count: deals.length,
              index: _currentIndex,
              color: Colors.grey.withOpacity(0.5),
              activeColor: Theme.of(context).primaryColor,
              height: 8,
              width: 8,
            ),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(dynamic deal) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: deal.imageUrl ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[300],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.error),
              ),
            ),
            // Add any overlay content, text, or buttons here
          ],
        ),
      ),
    );
  }
}
