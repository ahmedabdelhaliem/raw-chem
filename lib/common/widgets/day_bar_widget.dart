// import 'package:raw_chem/common/resources/color_manager.dart';
// import 'package:raw_chem/feature/home_coach/model/coach_schedule_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class DaysBarWidget extends StatefulWidget {
//   /// Callback لما يتغير اليوم
//   final Function(String selectedDate) onDaySelected;

//   /// List من الأيام لو جايه من API (أسماء فقط)
//   final List<String>? days;

//   /// بيانات الأسبوع كاملة من الـ API (التاريخ + اسم اليوم)
//   final List<Week>? weekData;

//   const DaysBarWidget({
//     super.key,
//     required this.onDaySelected,
//     this.days,
//     this.weekData,
//   });

//   @override
//   State<DaysBarWidget> createState() => _DaysBarWidgetState();
// }

// class _DaysBarWidgetState extends State<DaysBarWidget> {
//   final List<String> defaultDayNames = [
//     "السبت",
//     "الأحد",
//     "الإثنين",
//     "الثلاثاء",
//     "الأربعاء",
//     "الخميس",
//     "الجمعة"
//   ];

//   late int selectedIndex;

//   @override
//   void initState() {
//     super.initState();
//     // ابحث عن اليوم المختار من الـ weekData لو موجود
//     if (widget.weekData != null && widget.weekData!.isNotEmpty) {
//       selectedIndex = widget.weekData!.indexWhere((w) => w.isSelected == true);
//       if (selectedIndex == -1) selectedIndex = 0;
//     } else {
//       // في وضع الـ default، نختار اليوم الحالي
//       final todayName = _mapFlutterWeekdayToName(DateTime.now().weekday);
//       final names = widget.days ?? defaultDayNames;
//       selectedIndex = names.indexOf(todayName);
//       if (selectedIndex == -1) selectedIndex = 0;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         widget.onDaySelected(_getDateForDayName(names[selectedIndex]));
//       });
//     }
//   }

//   @override
//   void didUpdateWidget(covariant DaysBarWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // تحديث الاختيار لو الـ weekData اتغيرت (مثلاً عند تغيير الأسبوع)
//     if (widget.weekData != null && widget.weekData != oldWidget.weekData) {
//       int newIndex = widget.weekData!.indexWhere((w) => w.isSelected == true);
//       if (newIndex != -1) {
//         selectedIndex = newIndex;
//       }
//     }
//   }

//   String _getDateString(DateTime date) {
//     return "${date.year.toString().padLeft(4, '0')}-"
//         "${date.month.toString().padLeft(2, '0')}-"
//         "${date.day.toString().padLeft(2, '0')}";
//   }

//   String _mapFlutterWeekdayToName(int weekday) {
//     switch (weekday) {
//       case DateTime.monday:
//         return "الإثنين";
//       case DateTime.tuesday:
//         return "الثلاثاء";
//       case DateTime.wednesday:
//         return "الأربعاء";
//       case DateTime.thursday:
//         return "الخميس";
//       case DateTime.friday:
//         return "الجمعة";
//       case DateTime.saturday:
//         return "السبت";
//       case DateTime.sunday:
//         return "الأحد";
//       default:
//         return "السبت";
//     }
//   }

//   String _getDateForDayName(String dayName) {
//     DateTime now = DateTime.now();
//     int currentWeekday = now.weekday;
//     int targetFlutterWeekday = _mapNameToFlutterWeekday(dayName);
//     int diff = targetFlutterWeekday - currentWeekday;
//     DateTime targetDate = now.add(Duration(days: diff));
//     return _getDateString(targetDate);
//   }

//   int _mapNameToFlutterWeekday(String name) {
//     switch (name) {
//       case "الإثنين":
//         return DateTime.monday;
//       case "الثلاثاء":
//         return DateTime.tuesday;
//       case "الأربعاء":
//         return DateTime.wednesday;
//       case "الخميس":
//         return DateTime.thursday;
//       case "الجمعة":
//         return DateTime.friday;
//       case "السبت":
//         return DateTime.saturday;
//       case "الأحد":
//         return DateTime.sunday;
//       default:
//         return DateTime.saturday;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // تجهيز قائمة العناصر للعرض
//     final List<String> displayList = [];
//     final List<String> dateValues = [];

//     if (widget.weekData != null && widget.weekData!.isNotEmpty) {
//       for (var w in widget.weekData!) {
//         String name = w.isToday == true ? "اليوم" : _mapFlutterWeekdayToName(w.date!.weekday);
//         displayList.add("$name ${w.day}");
//         dateValues.add(_getDateString(w.date!));
//       }
//     } else {
//       // عرض أيام الأسبوع فقط بدون خيار الكل
//       final names = widget.days ?? defaultDayNames;
//       final todayName = _mapFlutterWeekdayToName(DateTime.now().weekday);
//       for (var name in names) {
//         displayList.add(name == todayName ? "اليوم" : name);
//         dateValues.add(_getDateForDayName(name));
//       }
//     }

//     return SizedBox(
//       height: .05.sh,
//       child: ListView.separated(
//         padding: EdgeInsets.symmetric(horizontal: 12.w),
//         scrollDirection: Axis.horizontal,
//         itemCount: displayList.length,
//         separatorBuilder: (_, __) => SizedBox(width: 10.w),
//         itemBuilder: (context, index) {
//           bool isSelected = selectedIndex == index;

//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 selectedIndex = index;
//               });
//               widget.onDaySelected(dateValues[index]);
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 15.w),
//               decoration: BoxDecoration(
//                 color: isSelected ? ColorManager.primary : Colors.white,
//                 borderRadius: BorderRadius.circular(30.r),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Center(
//                 child: Text(
//                   displayList[index],
//                   style: TextStyle(
//                     fontSize: 13.sp,
//                     color: isSelected ? Colors.white : Colors.black87,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
