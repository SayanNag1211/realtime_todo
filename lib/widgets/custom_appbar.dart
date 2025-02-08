import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_todo/constant/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.buttontap,
    this.menuonTap = false,
  });

  final String title;
  final Function()? buttontap;
  final bool menuonTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, state) {
        double textSize = state.maxWidth > 600 ? 6.sp : 18.sp;
        double iconsize = state.maxWidth > 600 ? 6.w : 15.w;
        return AppBar(
          elevation: 1,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: blue,
          surfaceTintColor: Colors.transparent,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                color: white,
                fontSize: textSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          actions: menuonTap == false
              ? []
              : [
                  GestureDetector(
                    onTap: buttontap,
                    child: Padding(
                      padding: EdgeInsets.only(right: 25.w),
                      child: Image.asset(
                        'assets/icons/delete.png',
                        color: white,
                        width: iconsize,
                      ),
                    ),
                  ),
                ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
