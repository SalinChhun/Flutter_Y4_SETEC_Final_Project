import 'package:ecommerce/res/constant/appfont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../model/Product/ProductModel.dart';
import '../../../res/constant/appcolor.dart';
import '../../client/product/MyProduct.dart';
import '../../client/product/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomCardList extends StatefulWidget {
  final Results? product; // Nullable product
  final int len; // Changed to int for better type safety

  CustomCardList({Key? key, this.product, required this.len}) : super(key: key);

  @override
  State<CustomCardList> createState() => _CustomCardListState();
}

class _CustomCardListState extends State<CustomCardList> {
  String? getFirstImageUrl() {
    if (widget.product?.imgid == null || widget.product!.imgid!.isEmpty) {
      return null;
    }
    return widget.product!.imgid![0].images;
  }

  double calculateDiscountedPrice() {
    if (widget.product?.price == null || widget.product?.discount == null) {
      return 0.0;
    }
    final price = widget.product!.price!;
    final discount = widget.product!.discount!;
    return price - (price * (discount / 100)).truncateToDouble();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product == null) {
      return const SizedBox.shrink();
    }

    final imageUrl = getFirstImageUrl() ?? 'http://via.placeholder.com/350x150';

    return GestureDetector(
      onTap: () async {
        try {
          final prefs = await SharedPreferences.getInstance();
          if (!mounted) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                userid: prefs.getInt("userid"),
                productss: MyProductDetail(
                  id: widget.product?.id,
                  imgid: widget.product?.imgid,
                  price: widget.product?.price,
                  categoryid: widget.product?.category?.id,
                  attribution: widget.product?.attribution,
                  discount: widget.product?.discount,
                  avgRating: widget.product?.avgRating,
                  description: widget.product?.description,
                  sellRating: widget.product?.sellRating,
                  productname: widget.product?.productname,
                  stockqty: widget.product?.stockqty,
                ),
              ),
            ),
          );
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error loading product details')),
          );
        }
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 155,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                        child: CircularProgressIndicator(
                          color: Color(AppColorConfig.success),
                          value: downloadProgress.progress,
                        ),
                      ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.product?.discount != null && widget.product!.discount! > 0)
                      Container(
                        decoration: BoxDecoration(
                          color: Color(AppColorConfig.negativelight),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(AppColorConfig.negativecolor),
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(4),
                        alignment: Alignment.center, 
                        child: Text(
                          "${widget.product!.discount}% OFF",
                          style: TextStyle(
                            color: Color(AppColorConfig.negativecolor),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      const SizedBox(height: 20),

                    Text(
                      widget.product?.productname ?? 'No name available',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeightConfig.medium,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$ ${calculateDiscountedPrice().toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeightConfig.medium,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Color(AppColorConfig.primarycolor),
                          radius: 14,
                          child: Image.asset(
                            'assets/logo/shopping-cart.png',
                            width: 16,
                            height: 16,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Free Shipping",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(AppColorConfig.primarycolor),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 20,
                              color: Colors.amberAccent,
                            ),
                            Text(
                              widget.product?.avgRating?.toStringAsFixed(1) ?? 'N/A',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}