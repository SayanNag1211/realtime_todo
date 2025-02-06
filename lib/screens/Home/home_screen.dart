import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_todo/constant/colors.dart';
import 'package:realtime_todo/widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Employee List"),
      body: Center(
        child: Image.asset(
          "assets/images/empty.png",
          width: 261.79.w,
          height: 244.38.h,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        onPressed: () {},
        child: Icon(
          Icons.add,
          weight: 18.w,
          color: white,
        ),
      ),
    );
  }
}
