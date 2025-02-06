import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton({
  required String text,
  required Function() onPressed,
  required Color color,
  required Color textColor,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: 44.h,
      width: 80.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}
