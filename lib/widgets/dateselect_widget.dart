import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_todo/constant/colors.dart';
import 'package:realtime_todo/widgets/custom_button.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

Widget dateselectbox({
  required BuildContext context,
}) {
  return InkWell(
    onTap: () {
      _showCalendarPopup(context);
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
            "No date",
            style: TextStyle(
              color: hint,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ),
  );
}

void _showCalendarPopup(BuildContext context) {
  DateTime _selectedDay = DateTime.now();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: white,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.52,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3.5,
                      mainAxisSpacing: 2),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      // width: 20.0.w,
                      margin: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: blue,
                        border: Border.all(color: border),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          'Box ${index + 1}',
                          style: TextStyle(
                            color: white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
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
                focusedDay: _selectedDay,
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                onDaySelected: (selectedDay, focusedDay) {
                  _selectedDay = selectedDay;
                  print(selectedDay);
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
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                          DateFormat('d MMM yyyy').format(_selectedDay),
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
                          onPressed: () {},
                          color: liblue,
                          textColor: blue,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        customButton(
                          text: 'Save',
                          onPressed: () {},
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
}
