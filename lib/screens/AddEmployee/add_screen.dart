import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_todo/constant/colors.dart';
import 'package:realtime_todo/widgets/custom_appbar.dart';
import 'package:realtime_todo/widgets/custom_button.dart';
import 'package:realtime_todo/widgets/custom_textfield.dart';
import 'package:realtime_todo/widgets/dateselect_widget.dart';

class AddDataScren extends StatelessWidget {
  const AddDataScren({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller = TextEditingController();

    List<String> roles = [
      "Product Designer",
      "Flutter Developer",
      "QA Tester",
      "Product Owner",
    ];
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppBar(title: "Add Employee Details"),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
                child: Column(
                  spacing: 20.h,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      height: 45.h,
                      child: customtextfield(
                        hintText: 'Employee name',
                        controller: namecontroller,
                        icon: Icons.person_outline,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.r)),
                          ),
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: roles.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            print("hello$index");
                                            Navigator.pop(context);
                                          },
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 18.h,
                                                ),
                                                child: Text(
                                                  roles[index],
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 1.h,
                                                color: border,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 45.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.r),
                          border: Border.all(color: border, width: 1.0.w),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 11.w,
                                ),
                                Icon(
                                  Icons.work_outline,
                                  color: blue,
                                  weight: 15.w,
                                ),
                                SizedBox(
                                  width: 14.w,
                                ),
                                Text(
                                  "Select role",
                                  style: TextStyle(
                                    color: hint,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: blue,
                              size: 35.h,
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dateselectbox(context: context),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: blue,
                          size: 22.sp,
                        ),
                        dateselectbox(context: context),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 2.h,
                  width: double.infinity,
                  color: border,
                ),
                SizedBox(
                  // height: 64.h,
                  width: double.infinity,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 10.w,
                      children: [
                        customButton(
                          text: 'Cancel',
                          onPressed: () {},
                          color: liblue,
                          textColor: blue,
                        ),
                        customButton(
                          text: 'Save',
                          onPressed: () {},
                          color: blue,
                          textColor: white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
