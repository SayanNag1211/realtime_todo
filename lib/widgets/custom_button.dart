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
    child: LayoutBuilder(
      builder: (context, state) {
        bool isWeb = state.maxWidth > 600;

        return Container(
          height: isWeb ? 44 : 44.h,
          width: isWeb ? 80 : 80.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: isWeb ? 14 : 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    ),
  );
}
