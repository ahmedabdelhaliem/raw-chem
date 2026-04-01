import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raw_chem/core/ui/skeleton/skeleton_bar.dart';
import 'package:raw_chem/core/ui/skeleton/skeleton_widget.dart';

class PersonalDataFormSkeleton extends StatelessWidget {
  PersonalDataFormSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(5, (index) => Padding(
          padding: EdgeInsets.only(bottom: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SkeletonBar(width: 80, height: 14),
              SizedBox(height: 8.h),
              SkeletonWidget(
                isLoading: true,
                child: Container(
                  height: 56.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
