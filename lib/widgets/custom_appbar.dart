import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_todo/constant/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.backonTap,
    this.menuonTap = false,
  });

  final String title;
  final Function()? backonTap;
  final bool menuonTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: true,
      backgroundColor: blue,
      surfaceTintColor: Colors.transparent,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      leading: menuonTap == false
          ? null
          : GestureDetector(
              onTap: backonTap,
              child: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
