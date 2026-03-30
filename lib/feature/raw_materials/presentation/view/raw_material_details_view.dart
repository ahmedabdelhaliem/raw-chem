import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/common/resources/color_manager.dart';
import 'package:raw_chem/common/widgets/default_app_bar.dart';
import 'package:raw_chem/common/widgets/default_button_widget.dart';
import 'package:raw_chem/feature/raw_materials/presentation/view/widgets/packages_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';

class RawMaterialDetailsView extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String category;
  final String description;
  final String casNumber;
  final String averagePrice;
  final String supplier;
  final String heroTag;

  const RawMaterialDetailsView({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.description,
    required this.casNumber,
    required this.averagePrice,
    required this.supplier,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bg,
      appBar: DefaultAppBar(
        text: 'تفاصيل المنتج',
        backgroundColor: ColorManager.bg,
        titleColor: ColorManager.black,
        withLeading: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image
            Hero(
              tag: heroTag,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFFF3FAF0),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 250.h,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(color: Colors.white, height: 250.h),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Title & Category
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1B3D2F),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE2F9D1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF4A7D2C),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Description
            _buildInfoSection('الوصف :', description),
            SizedBox(height: 15.h),

            // Average Price
            _buildInfoRow('متوسط السعر : ', averagePrice),
            SizedBox(height: 15.h),

            // Meta Data
            _buildInfoSection('التفاصيل الفنية', '', isTitle: true),
            SizedBox(height: 8.h),
            _buildInfoRow('CAS Number: ', casNumber),
            SizedBox(height: 8.h),
            _buildInfoRow('المورد : ', supplier),
            
            SizedBox(height: 40.h),

            // Action Buttons
            DefaultButtonWidget(
              text: 'أضف للسلة',
              onPressed: () {
                // TODO: Add cart logic
              },
              color: ColorManager.white,
              textColor: const Color(0xFF006B3E),
              withBorder: true,
              borderColor: const Color(0xFF006B3E),
              radius: 12.r,
              height: 50.h,
            ),
            SizedBox(height: 15.h),
            DefaultButtonWidget(
              text: 'اتصل بالمورد',
              onPressed: () {
                PackagesBottomSheet.show(context);
              },
              color: const Color(0xFF006B3E),
              textColor: Colors.white,
              radius: 12.r,
              height: 50.h,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String content, {bool isTitle = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isTitle ? FontWeight.bold : FontWeight.w500,
            color: isTitle ? const Color(0xFF1B3D2F) : const Color(0xFFB4B4CC),
          ),
          textAlign: TextAlign.right,
        ),
        if (content.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF1B3D2F),
              height: 1.5,
            ),
            textAlign: TextAlign.right,
          ),
        ]
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B3D2F),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: const Color(0xFFB4B4CC),
          ),
        ),
      ],
    );
  }
}
