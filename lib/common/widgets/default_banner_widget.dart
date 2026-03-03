import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import 'shimmer_container_widget.dart';

class DefaultBannerWidget<T> extends StatefulWidget {
  final List<T> images;
  final String Function(T image) imageUrl;
  final void Function(T image, int index)? imageOnTap;
  final bool enlargeCenterPage;
  final double aspectRatio;
  final double viewportFraction;
  final double enlargeFactor;
  final bool isLoading;
  final bool showIndicators;

  final String Function(T image)? title;
  final String Function(T image)? subtitle;
  final bool Function(T image)? isSpecialOffer;

  const DefaultBannerWidget({
    super.key,
    required this.images,
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.isSpecialOffer,
    this.imageOnTap,
    this.enlargeCenterPage = true,
    this.aspectRatio = 16 / 7,
    this.viewportFraction = 1,
    this.enlargeFactor = .3,
    this.isLoading = false,
    this.showIndicators = true,
  });

  @override
  State<DefaultBannerWidget<T>> createState() => _DefaultBannerWidgetState<T>();
}

class _DefaultBannerWidgetState<T> extends State<DefaultBannerWidget<T>> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // حالة التحميل أو لا يوجد صور
    if (widget.isLoading || widget.images.isEmpty) {
      return AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: const ShimmerContainerWidget(height: double.infinity),
          ),
        ),
      );
    }

    // حالة صورة واحدة
    if (widget.images.length == 1) {
      return AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: _buildImage(widget.images.first, 0, applyPadding: false),
      );
    }

    // حالة أكثر من صورة
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        carousel.CarouselSlider(
          items: widget.images
              .asMap()
              .entries
              .map((entry) => _buildImage(entry.value, entry.key, applyPadding: true))
              .toList(),
          options: carousel.CarouselOptions(
            initialPage: 0,
            enableInfiniteScroll: true,
            viewportFraction: widget.viewportFraction,
            enlargeCenterPage: widget.enlargeCenterPage,
            enlargeFactor: widget.enlargeFactor,
            aspectRatio: widget.aspectRatio,
            autoPlay: widget.images.length > 1,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 500),
            autoPlayCurve: Curves.easeInOut,
            pauseAutoPlayOnTouch: true,
            pageSnapping: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        if (widget.showIndicators) _buildIndicators(),
      ],
    );
  }

  // بناء صورة واحدة مع fade-in
  Widget _buildImage(T image, int index, {required bool applyPadding}) {
    return GestureDetector(
      onTap: () => widget.imageOnTap?.call(image, index),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: applyPadding ? 10.w : 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: widget.imageUrl(image),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const ShimmerContainerWidget(height: double.infinity),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      ColorManager.black.withOpacity(0.7),
                      ColorManager.black.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              // Content Overlay
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (widget.isSpecialOffer?.call(image) ?? false)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: ColorManager.yellow,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'عرض خاص',
                          style: TextStyle(
                            color: ColorManager.black,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (widget.title != null) ...[
                      SizedBox(height: 8.h),
                      Text(
                        widget.title!(image),
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                    if (widget.subtitle != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        widget.subtitle!(image),
                        style: TextStyle(
                          color: ColorManager.white.withOpacity(0.9),
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Indicators متحركة
  Widget _buildIndicators() {
    return Positioned(
      bottom: 8.h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.images.asMap().entries.map((entry) {
          final isActive = _currentIndex == entry.key;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isActive ? 12.w : 8.w,
            height: 8.w,
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            decoration: BoxDecoration(
              color: isActive ? ColorManager.blue : ColorManager.lightGrey,
              borderRadius: BorderRadius.circular(4.r),
            ),
          );
        }).toList(),
      ),
    );
  }
}
