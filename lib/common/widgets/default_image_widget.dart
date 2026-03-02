import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DefaultImageWidget extends StatelessWidget {
  final String? image; // خليها nullable
  final double? width;
  final double? height;
  final double? radius;
  final bool isCircle;
  final BoxFit? fit;
  final void Function()? onTap;
  final Color placeholderColor;
  final bool showShadow;
  final bool isProfile;
  final Widget? placeholderWidget;

  const DefaultImageWidget({
    super.key,
    this.image,
    this.width,
    this.height,
    this.radius,
    this.isCircle = false,
    this.fit,
    this.onTap,
    this.placeholderColor = const Color(0xFFE0E0E0),
    this.showShadow = false,
    this.isProfile = false,
    this.placeholderWidget,
  });

  @override
  Widget build(BuildContext context) {
    Widget img;
    String? effectiveImageUrl = image;

    if (effectiveImageUrl != null && effectiveImageUrl.isNotEmpty) {
      String imageUrl = effectiveImageUrl.trim();
      const String prefixBase = 'https://app-coachizer.brmjatech.uk/uploads/users/';
      const String baseUrl = 'https://app-coachizer.brmjatech.uk/';

      // 1. Handle relative paths smartly
      if (!imageUrl.startsWith('http')) {
        if (imageUrl.startsWith('uploads/')) {
          imageUrl = '$baseUrl$imageUrl';
        } else if (imageUrl.startsWith('/uploads/')) {
          imageUrl = '$baseUrl${imageUrl.substring(1)}';
        } else {
          imageUrl = '$prefixBase$imageUrl';
        }
      }

      // 2. Clean up any redundancy in absolute URLs
      // Handle cases like prefix/uploads/...
      if (imageUrl.contains('uploads/users/uploads/')) {
        imageUrl = imageUrl.replaceFirst('uploads/users/', '');
      }

      // 3. Recursive cleanup for any doubled prefixes or http patterns
      while (imageUrl.contains('${prefixBase}https')) {
        imageUrl = imageUrl.replaceFirst(prefixBase, '');
      }

      final RegExp doubleHttpPattern = RegExp(r'(https?://.*/uploads/[^/]+/)(https?://)');
      while (doubleHttpPattern.hasMatch(imageUrl)) {
        imageUrl = imageUrl.replaceFirst(doubleHttpPattern.firstMatch(imageUrl)!.group(1)!, '');
      }

      effectiveImageUrl = imageUrl;
    }

    if (effectiveImageUrl == null || effectiveImageUrl.isEmpty) {
      // لو مفيش صورة نعرض placeholder
      img = placeholderWidget ??
          Container(
            width: width,
            height: height,
            color: placeholderColor,
            child: Center(
              child: Icon(
                isProfile ? Iconsax.user : Icons.image,
                size: (width != null && width! < 50) ? 20 : 40,
                color: Colors.grey,
              ),
            ),
          );
    } else {
      img = CachedNetworkImage(
        imageUrl: effectiveImageUrl,
        width: width ?? double.infinity,
        height: height,
        fit: fit ?? BoxFit.cover,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: placeholderColor,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: placeholderColor,
          child: Center(
            child: Icon(
              isProfile ? Iconsax.user : Icons.broken_image,
              size: (width != null && width! < 50) ? 20 : 40,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    Widget decorated = isCircle
        ? ClipOval(child: img)
        : ClipRRect(borderRadius: BorderRadius.circular(radius ?? 0), child: img);

    // Enforce size if provided to prevent layout collapse
    if (width != null || height != null) {
      decorated = SizedBox(
        width: width,
        height: height,
        child: decorated,
      );
    }

    if (showShadow) {
      decorated = Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
          borderRadius: isCircle ? null : BorderRadius.circular(radius ?? 0),
        ),
        child: decorated,
      );
    }

    return InkWell(onTap: onTap, child: decorated);
  }
}
