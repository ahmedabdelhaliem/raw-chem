// import 'package:raw_chem/app/app_functions.dart';
// import 'package:raw_chem/app/imports.dart';
// import 'package:raw_chem/common/base/base_state.dart';
// import 'package:raw_chem/common/resources/app_router.dart';
// import 'package:raw_chem/common/resources/color_manager.dart';
// import 'package:raw_chem/common/resources/strings_manager.dart';
// import 'package:raw_chem/common/widgets/default_button_widget.dart';
// import 'package:raw_chem/common/widgets/rating_bar_widget.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';

// class RatingDialogExample extends StatefulWidget {
//   // final int tripId;
//   final int userId;
//   final String title;

//   const RatingDialogExample({
//     super.key,
//     // required this.Id,
//     required this.userId,
//     required this.title,
//   });

//   @override
//   State<RatingDialogExample> createState() => _RatingDialogExampleState();
// }

// class _RatingDialogExampleState extends State<RatingDialogExample> {
//   final commentController = TextEditingController();
//   int rate = 0;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => instance<EvaluationCubit>(),
//       child: Dialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
//         child: Padding(
//           padding: EdgeInsets.all(16.w),
//           child: BlocConsumer<EvaluationCubit, BaseState<String>>(
//             listener: (context, state) {
//               if (state.isSuccess) {
//                 Navigator.pop(context);

//                 Future.delayed(const Duration(milliseconds: 300), () {
//                   context.go(AppRouters.homeView);
//                 });

//                 AppFunctions.showsToast(
//                   AppStrings.thankYouForYourEvaluation.tr(),
//                   ColorManager.successGreen,
//                   context,
//                 );
//               } else if (state.isFailure) {
//                 AppFunctions.showsToast(
//                   state.errorMessage ?? '',
//                   ColorManager.red,
//                   context,
//                 );
//               }
//             },
//             builder: (context, state) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(widget.title,
//                       style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 16.h),
//                   RatingBarWidget(
//                     enable: true,
//                     rating: rate.toDouble(),
//                     itemSize: 30.r,
//                     onRatingUpdate: (r) => setState(() => rate = r.toInt()),
//                   ),
//                   SizedBox(height: 16.h),
//                   // DefaultFormField(
//                   //   controller: commentController,
//                   //   hintText: AppStrings.writeCaptainComment.tr(),
//                   //   maxLines: 5,
//                   //   borderColor: ColorManager.greyBorder,
//                   // ),
//                   SizedBox(height: 16.h),
//                   DefaultButtonWidget(
//                     isLoading: state.isLoading,
//                     text: state.isLoading ? AppStrings.loading.tr() : AppStrings.send.tr(),
//                     color: ColorManager.primary,
//                     textColor: Colors.white,
//                     onPressed: state.isLoading
//                         ? null
//                         : () {
//                             context.read<EvaluationCubit>().createEvaluation(
//                                   userId: widget.userId,
//                                   comment: commentController.text,
//                                   rate: rate,
//                                 );
//                           },
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
