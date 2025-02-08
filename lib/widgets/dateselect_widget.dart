import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_todo/constant/colors.dart';
import 'package:realtime_todo/screens/AddEmployee/bloc/add_bloc.dart';
import 'package:realtime_todo/widgets/custom_button.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

Widget dateselectbox({
  required BuildContext context,
  required String txt,
  required bool isFromDate,
}) {
  return InkWell(
    onTap: () {
      isFromDate == true
          ? _showFromCalendarPopup(context)
          : _showToCalendarPopup(context);
    },
    child: Container(
      height: 45.h,
      width: 172.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.r),
        border: Border.all(color: border, width: 1.0.w),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 11.w,
          ),
          Image.asset(
            'assets/icons/calender.png',
            width: 22.w,
            height: 22.h,
          ),
          SizedBox(
            width: 14.w,
          ),
          Text(
            txt,
            style: TextStyle(
              color: txt == "No date" ? hint : maintxt,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ),
  );
}

void _showFromCalendarPopup(BuildContext context) {
  DateTime selectedDay = DateTime.now();
  List<Map<String, String>> gridbar = [
    {"key": "FromDateStatus.today", "title": "Today"},
    {"key": "FromDateStatus.nextMon", "title": "Next Monday"},
    {"key": "FromDateStatus.nextTues", "title": "Next Tuesday"},
    {"key": "FromDateStatus.nextWeek", "title": "After 1 week"}
  ];
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<AddBloc, AddState>(
        builder: (context, state) {
          return AlertDialog(
            backgroundColor: white,
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.56,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3.5,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: gridbar.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            context.read<AddBloc>().add(
                                  ChangeFromdate(index: index),
                                );
                          },
                          child: Container(
                            // width: 20.0.w,
                            margin: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              color: state.fdstatus.toString() ==
                                      gridbar[index]['key'].toString()
                                  ? blue
                                  : liblue,
                              border: Border.all(color: border),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                gridbar[index]['title'].toString(),
                                style: TextStyle(
                                  color: state.fdstatus.toString() ==
                                          gridbar[index]['key'].toString()
                                      ? white
                                      : blue,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: state.fromDate ?? selectedDay,
                    // selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                    selectedDayPredicate: (day) {
                      return isSameDay(state.fromDate, day);
                    },
                    calendarFormat: CalendarFormat.month,
                    onDaySelected: (selectedDay, focusedDay) {
                      selectedDay = selectedDay;
                      BlocProvider.of<AddBloc>(context).add(
                        FromDataEvent(
                          fromDate: selectedDay,
                        ),
                      );
                      // setState(() {
                      //   _selectedDay = selectedDay;
                      // });
                      // Navigator.pop(context); // Close the popup
                    },
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: blue,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        border: Border.all(color: blue),
                        shape: BoxShape.circle,
                      ),
                      defaultTextStyle: TextStyle(color: Colors.black),
                      // weekNumberTextStyle: TextStyle(color: Colors.black),
                      weekendTextStyle: TextStyle(color: Colors.black),
                      selectedTextStyle: TextStyle(color: white),
                      todayTextStyle: TextStyle(color: blue),
                    ),
                    rowHeight: 40.h,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: maintxt,
                      ),
                      headerPadding: EdgeInsets.zero,
                      leftChevronIcon: Image.asset(
                        "assets/icons/arrow.png",
                        scale: 3.5,
                      ),
                      rightChevronIcon: Transform.rotate(
                        angle: 180 * (3.1415926535897932 / 180),
                        child: Image.asset(
                          "assets/icons/arrow.png",
                          scale: 3.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 1.w,
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 11.w,
                            ),
                            Image.asset(
                              'assets/icons/calender.png',
                              width: 22.w,
                              height: 22.h,
                            ),
                            SizedBox(
                              width: 14.w,
                            ),
                            Text(
                              DateFormat('d MMM yyyy')
                                  .format(state.fromDate ?? selectedDay),
                              style: TextStyle(
                                color: maintxt,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            customButton(
                              text: 'Cancel',
                              onPressed: () {
                                BlocProvider.of<AddBloc>(context).add(
                                  FromDataEvent(
                                    fromDate: selectedDay,
                                  ),
                                );
                                Navigator.pop(context);
                                // print(state.fromDate);
                              },
                              color: liblue,
                              textColor: blue,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            customButton(
                              text: 'Save',
                              onPressed: () {
                                BlocProvider.of<AddBloc>(context).add(
                                  FromDataEvent(
                                    fromDate: state.fromDate,
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              color: blue,
                              textColor: white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

void _showToCalendarPopup(BuildContext context) {
  DateTime selectedDay = DateTime.now();
  List<Map<String, String>> gridbar = [
    {"key": "ToDateStatus.nodate", "title": "No date"},
    {"key": "ToDateStatus.today", "title": "Today"},
  ];
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<AddBloc, AddState>(
        builder: (context, state) {
          return AlertDialog(
            backgroundColor: white,
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.52,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(2, (index) {
                        return InkWell(
                          onTap: () {
                            print('--------------------->>>> $index');
                            BlocProvider.of<AddBloc>(context)
                                .add(ChangeToFrodate(index: index));
                          },
                          child: Container(
                            // margin: EdgeInsets.all(4.r),
                            height: 40.h,
                            width: MediaQuery.of(context).size.width * 0.35,
                            decoration: BoxDecoration(
                              color: state.tdstatus.toString() ==
                                      gridbar[index]['key'].toString()
                                  ? blue
                                  : liblue,
                              border: Border.all(color: border),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                gridbar[index]['title'].toString(),
                                style: TextStyle(
                                  color: state.tdstatus.toString() ==
                                          gridbar[index]['key'].toString()
                                      ? white
                                      : blue,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: state.toDate ?? selectedDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(state.toDate, day);
                    },
                    calendarFormat: CalendarFormat.month,
                    onDaySelected: (selectedDay, focusedDay) {
                      selectedDay = selectedDay;
                      BlocProvider.of<AddBloc>(context).add(
                        FromDataEvent(
                          isNotime: false,
                          toDate: selectedDay,
                        ),
                      );
                      // setState(() {
                      //   _selectedDay = selectedDay;
                      // });
                      // Navigator.pop(context); // Close the popup
                    },
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: blue,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        border: Border.all(color: blue),
                        shape: BoxShape.circle,
                      ),
                      defaultTextStyle: TextStyle(color: Colors.black),
                      // weekNumberTextStyle: TextStyle(color: Colors.black),
                      weekendTextStyle: TextStyle(color: Colors.black),
                      selectedTextStyle: TextStyle(color: white),
                      todayTextStyle: TextStyle(color: blue),
                    ),
                    rowHeight: 40.h,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: maintxt,
                      ),
                      headerPadding: EdgeInsets.zero,
                      leftChevronIcon: Image.asset(
                        "assets/icons/arrow.png",
                        scale: 3.5,
                      ),
                      rightChevronIcon: Transform.rotate(
                        angle: 180 * (3.1415926535897932 / 180),
                        child: Image.asset(
                          "assets/icons/arrow.png",
                          scale: 3.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 1.w,
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 11.w,
                            ),
                            Image.asset(
                              'assets/icons/calender.png',
                              width: 22.w,
                              height: 22.h,
                            ),
                            SizedBox(
                              width: 14.w,
                            ),
                            Text(
                              state.isNotime == true
                                  ? "No date"
                                  : (state.toDate != null
                                      ? DateFormat('d MMM yyyy')
                                          .format(state.toDate!)
                                      : "No date"),
                              style: TextStyle(
                                color: maintxt,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            customButton(
                              text: 'Cancel',
                              onPressed: () {
                                Navigator.pop(context);
                                // print(state.fromDate);
                              },
                              color: liblue,
                              textColor: blue,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            customButton(
                              text: 'Save',
                              onPressed: () {
                                BlocProvider.of<AddBloc>(context).add(
                                  FromDataEvent(
                                    isNotime: state.isNotime,
                                    toDate: state.toDate,
                                  ),
                                );
                                // print(state.toDate);
                                Navigator.pop(context);
                              },
                              color: blue,
                              textColor: white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
