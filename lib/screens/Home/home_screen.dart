import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:realtime_todo/constant/colors.dart';
import 'package:realtime_todo/screens/Add&EditEmployee/bloc/add_bloc.dart';
import 'package:realtime_todo/screens/Home/bloc/home_bloc.dart';
import 'package:realtime_todo/widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (DataStatus.empty == state.status) {
            return Scaffold(
              backgroundColor: homebg,
              appBar: CustomAppBar(title: "Employee List"),
              body: Center(
                child: Image.asset(
                  "assets/images/empty.png",
                  width: 261.79.w,
                  height: 244.38.h,
                ),
              ),
              floatingActionButton: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                onPressed: () {
                  context.push('/addscreen', extra: {
                    'isEdit': false,
                    'id': '',
                    'name': '',
                  });
                },
                backgroundColor: blue,
                child: Icon(
                  Icons.add,
                  color: white,
                ),
              ),
            );
          } else {
            return LayoutBuilder(
              builder: (context, s) {
                bool isWeb = s.maxWidth > 600;
                return Scaffold(
                  backgroundColor: homebg,
                  appBar: CustomAppBar(title: "Employee List"),
                  body: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16.h),
                                child: Text(
                                  "Current employees",
                                  style: TextStyle(
                                    fontSize: isWeb ? 15 : 16.sp,
                                    color: blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.details!
                                    .where((e) => e.toDate.isEmpty)
                                    .toList()
                                    .length,
                                itemBuilder: (context, index) {
                                  final val = state.details!
                                      .where((v) => v.toDate.isEmpty)
                                      .toList()[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 1.h),
                                    child: Slidable(
                                      key: Key(val.id.toString()),
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        extentRatio: 0.25,
                                        children: [
                                          SlidableAction(
                                            onPressed: (_) {
                                              BlocProvider.of<HomeBloc>(context)
                                                  .add(
                                                DeleteDataEvent(
                                                  index: index,
                                                  context: context,
                                                  isUndo: false,
                                                ),
                                              );
                                            },
                                            backgroundColor: red,
                                            foregroundColor: white,
                                            icon: Icons.delete,
                                            spacing: 32.0,
                                          )
                                        ],
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          context.read<AddBloc>().add(
                                                AllDataEvent(
                                                  role: val.role,
                                                  // toDate: DateFormat("d MMMM yyyy")
                                                  //     .parseLoose(val.toDate),
                                                  fromDate: DateFormat(
                                                          "d MMMM yyyy")
                                                      .parseLoose(val.fromDate),
                                                  isNotime: true,
                                                ),
                                              );
                                          context.push(
                                            '/addscreen',
                                            extra: {
                                              'isEdit': true,
                                              'id': val.id,
                                              'name': val.name
                                            },
                                          );
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(16.h),
                                          color: white,
                                          child: Column(
                                            spacing: 5.h,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                val.name,
                                                style: TextStyle(
                                                  color: maintxt,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: isWeb ? 17 : 18.sp,
                                                ),
                                              ),
                                              Text(
                                                val.role,
                                                style: TextStyle(
                                                  color: subtxt,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: isWeb ? 15 : 14.sp,
                                                ),
                                              ),
                                              Text(
                                                "From ${val.fromDate}",
                                                style: TextStyle(
                                                  color: subtxt,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: isWeb ? 14 : 12.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              // Previous employees
                              Padding(
                                padding: EdgeInsets.all(16.h),
                                child: Text(
                                  "Previous employees",
                                  style: TextStyle(
                                    fontSize: isWeb ? 15 : 16.sp,
                                    color: blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.details!
                                    .where((e) => e.toDate.isNotEmpty)
                                    .toList()
                                    .length,
                                itemBuilder: (context, index) {
                                  final val = state.details!
                                      .where((v) => v.toDate.isNotEmpty)
                                      .toList()[index];

                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 1.h),
                                    child: Slidable(
                                      key: Key(val.id.toString()),
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        extentRatio: 0.25,
                                        children: [
                                          SlidableAction(
                                            onPressed: (_) {
                                              BlocProvider.of<HomeBloc>(context)
                                                  .add(
                                                DeleteDataEvent(
                                                  index: index,
                                                  context: context,
                                                  isUndo: false,
                                                ),
                                              );
                                            },
                                            backgroundColor: red,
                                            foregroundColor: white,
                                            icon: Icons.delete_forever_outlined,
                                            // label: 'Delete',
                                          )
                                        ],
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          context.read<AddBloc>().add(
                                                AllDataEvent(
                                                    role: val.role,
                                                    toDate: DateFormat(
                                                            "d MMMM yyyy")
                                                        .parseLoose(val.toDate),
                                                    fromDate: DateFormat(
                                                            "d MMMM yyyy")
                                                        .parseLoose(
                                                            val.fromDate),
                                                    isNotime: true),
                                              );
                                          context.push(
                                            '/addscreen',
                                            extra: {
                                              'isEdit': true,
                                              'id': val.id,
                                              'name': val.name
                                            },
                                          );
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(16.h),
                                          color: white,
                                          child: Column(
                                            spacing: 5.h,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                val.name,
                                                style: TextStyle(
                                                  color: maintxt,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: isWeb ? 17 : 18.sp,
                                                ),
                                              ),
                                              Text(
                                                val.role,
                                                style: TextStyle(
                                                  color: subtxt,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: isWeb ? 15 : 14.sp,
                                                ),
                                              ),
                                              Text(
                                                '${val.fromDate}-${val.toDate}',
                                                style: TextStyle(
                                                  color: subtxt,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: isWeb ? 14 : 12.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: state.isUndo == true ? maintxt : homebg,
                        height: state.isUndo == true ? 110.h : 75.h,
                        child: Column(
                          children: [
                            Container(
                              color: homebg,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: isWeb ? 15 : 20.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 10.w,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      child: Text(
                                        "Swipe left to delete",
                                        style: TextStyle(
                                          color: subtxt,
                                          fontWeight: FontWeight.w400,
                                          fontSize: isWeb ? 14 : 15.sp,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 5.h),
                                      child: InkWell(
                                        onTap: () {
                                          context.push('/addscreen', extra: {
                                            'isEdit': false,
                                            'id': '',
                                            'name': '',
                                          });
                                        },
                                        child: Container(
                                          height: 53.h,
                                          width: 53.h,
                                          decoration: BoxDecoration(
                                            color: blue,
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // if (state.isUndo == true)
                      // Container(
                      //   // ignore: deprecated_member_use
                      //   color: maintxt.withOpacity(0.6),
                      //   // height: 40.h,
                      //   padding: EdgeInsets.only(left: 20.w, right: 5.w),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         'Employee data has been deleted',
                      //         style: TextStyle(
                      //           color: white,
                      //           fontSize: 15.sp,
                      //           fontWeight: FontWeight.w400,
                      //         ),
                      //       ),
                      //       TextButton(
                      //         onPressed: () {
                      //           BlocProvider.of<HomeBloc>(context).add(
                      //             DeleteDataEvent(
                      //               index: 0,
                      //               context: context,
                      //               isUndo: true,
                      //             ),
                      //           );

                      //           // _toggleSnackBar();
                      //           // ScaffoldMessenger.of(context).showSnackBar(
                      //           //   SnackBar(content: Text('Button clicked!')),
                      //           // );
                      //         },
                      //         child: Text(
                      //           'Undo',
                      //           style: TextStyle(color: blue, fontSize: 15.sp),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),

                  // bottomNavigationBar:
                );
              },
            );
          }
        },
      ),
    );
  }
}
