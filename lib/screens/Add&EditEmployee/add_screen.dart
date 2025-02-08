// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:realtime_todo/constant/colors.dart';
import 'package:realtime_todo/screens/Add&EditEmployee/bloc/add_bloc.dart';
import 'package:realtime_todo/widgets/custom_appbar.dart';
import 'package:realtime_todo/widgets/custom_button.dart';
import 'package:realtime_todo/widgets/custom_textfield.dart';
import 'package:realtime_todo/widgets/dateselect_widget.dart';

// ignore: must_be_immutable
class AddDataScren extends StatelessWidget {
  bool isEdit;
  String id;
  String name;
  AddDataScren({super.key, required this.isEdit, this.id = '', this.name = ''});

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller = TextEditingController(text: name);

    List<String> roles = [
      "Product Designer",
      "Flutter Developer",
      "QA Tester",
      "Product Owner",
    ];
    return SafeArea(
      top: false,
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: () async {
          context.pop();
          return false;
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: isEdit == false
                ? "Add Employee Details"
                : "Edit Employee Details",
            menuonTap: isEdit ? true : false,
            buttontap: () {
              context.read<AddBloc>().add(DeletPerEvent(id: id));
              context.pop();
            },
          ),
          body: BlocBuilder<AddBloc, AddState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 18.h, horizontal: 16.w),
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
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                          ),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: roles.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  BlocProvider.of<AddBloc>(
                                                          context)
                                                      .add(
                                                    RoleEvent(
                                                      role: roles[index],
                                                    ),
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 18.h,
                                                      ),
                                                      child: Text(
                                                        roles[index],
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        state.role == ''
                                            ? "Select role"
                                            : state.role,
                                        style: TextStyle(
                                          color:
                                              state.role == '' ? hint : maintxt,
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
                              dateselectbox(
                                context: context,
                                txt: state.fromDate != null
                                    ? DateFormat("d MMM yyyy")
                                        .format(state.fromDate!)
                                        .toString()
                                    : "Today",
                                isFromDate: true,
                              ),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: blue,
                                size: 22.sp,
                              ),
                              dateselectbox(
                                context: context,
                                txt: state.isNotime == true
                                    ? "No date"
                                    : (state.toDate != null
                                        ? DateFormat('d MMM yyyy')
                                            .format(state.toDate!)
                                        : "No date"),
                                //  state.toDate != null
                                //     ? DateFormat("d MMM yyyy")
                                //         .format(state.toDate!)
                                //         .toString()
                                //     : "No date",
                                isFromDate: false,
                              ),
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
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            spacing: 10.w,
                            children: [
                              customButton(
                                text: 'Cancel',
                                onPressed: () {
                                  context.pop();
                                },
                                color: liblue,
                                textColor: blue,
                              ),
                              customButton(
                                text: 'Save',
                                onPressed: () {
                                  isEdit
                                      ? BlocProvider.of<AddBloc>(context).add(
                                          updateDataEvent(
                                            id: id,
                                            name: namecontroller.value.text,
                                          ),
                                        )
                                      : BlocProvider.of<AddBloc>(context).add(
                                          AddDataEvent(
                                            name: namecontroller.value.text,
                                          ),
                                        );
                                  namecontroller.clear();
                                  context.pop();
                                  // BlocProvider.of<AddBloc>(context).add(
                                  //   AddDataEvent(
                                  //     details: Details(
                                  //       id: DateTime.now().toString(),
                                  //       name: namecontroller.text,
                                  //       role: e,
                                  //       fromDate: "12jul",
                                  //       toDate: "0299",
                                  //     ),
                                  //   ),
                                  // );
                                },
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
              );
            },
          ),
        ),
      ),
    );
  }
}
