import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../model/Product/ProductModel.dart';
import '../../../res/constant/appcolor.dart';
import '../../client/product/MyProduct.dart';
import '../../client/product/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomCardList extends StatefulWidget {
  final Results? product;
  final int len;

  const CustomCardList({Key? key, this.product, required this.len}) : super(key: key);

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
            SnackBar(
              content: const Text('Error loading product details'),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'product-${widget.product?.id}',
              child: Container(
                width: 130,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(AppColorConfig.success),
                        value: downloadProgress.progress,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[100],
                      child: const Icon(
                        Icons.error_outline,
                        size: 32,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.product?.discount != null && widget.product!.discount! > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(AppColorConfig.negativecolor).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "${widget.product!.discount}% OFF",
                          style: TextStyle(
                            color: Color(AppColorConfig.negativecolor),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      widget.product?.productname ?? 'No name available',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "\$${calculateDiscountedPrice().toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(AppColorConfig.primarycolor),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(AppColorConfig.primarycolor).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            size: 20,
                            color: Color(AppColorConfig.primarycolor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(AppColorConfig.primarycolor).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.local_shipping_outlined,
                                size: 14,
                                color: Color(AppColorConfig.primarycolor),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Free",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(AppColorConfig.primarycolor),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.product?.avgRating?.toStringAsFixed(1) ?? 'N/A',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
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