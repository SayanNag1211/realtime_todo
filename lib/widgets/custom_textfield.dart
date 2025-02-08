import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_todo/constant/colors.dart';

Widget customtextfield(
    {required String hintText,
    required TextEditingController controller,
    required IconData icon}) {
  return LayoutBuilder(
    builder: (context, state) {
      bool isWeb = state.maxWidth > 600;

      return TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: border, width: isWeb ? 0.5.w : 1.0.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: border, width: isWeb ? 0.5.w : 1.0.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: border, width: isWeb ? 0.5.w : 1.0.w),
          ),
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: blue,
            weight: 15.w,
          ),
          hintStyle: TextStyle(
            color: hint,
            fontSize: isWeb ? 4.sp : 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        style: TextStyle(
          height: 1.0.h,
          fontSize: isWeb ? 4.sp : 16.sp,
          fontWeight: FontWeight.w400,
        ),
      );
    },
  );
}
