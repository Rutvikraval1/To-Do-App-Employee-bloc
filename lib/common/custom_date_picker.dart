import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar_null_safe/table_calendar_null_safe.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import '../app_theme.dart';

Future<DateTime?> customDatePicker({
  required BuildContext context,
  required DateTime? selectedDate,
  required CalendarController calendarController,
  required bool isJoiningDate,
}) {
  late List<List<Map<String, dynamic>>> entries;
  final DateTime todaysDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  if (selectedDate != null) {
    selectedDate = selectedDate.toLocal();
    selectedDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
  }
  if (isJoiningDate) {
    entries = [
      [
        {
          'label': 'Today',
          'isSelected': (DateTime? selectedDate) {
            return todaysDate == selectedDate;
          },
          'callback': () {
            Navigator.of(context).pop(todaysDate);
          }
        },
        {
          'label': 'Next Monday',
          'isSelected': (DateTime? selectedDate) {
            int difference = DateTime.monday - todaysDate.weekday;
            int daysToAdd = difference > 0 ? difference : 7 + difference;
            return selectedDate == todaysDate.add(Duration(days: daysToAdd));
          },
          'callback': () {
            int difference = DateTime.monday - todaysDate.weekday;
            int daysToAdd = difference > 0 ? difference : 7 + difference;
            Navigator.of(context).pop(
              todaysDate.add(Duration(days: daysToAdd)),
            );
          }
        }
      ],
      [
        {
          'label': 'Next Tuesday',
          'isSelected': (DateTime? selectedDate) {
            int difference = DateTime.tuesday - todaysDate.weekday;
            int daysToAdd = difference > 0 ? difference : 7 + difference;
            return selectedDate == todaysDate.add(Duration(days: daysToAdd));
          },
          'callback': () {
            int difference = DateTime.tuesday - todaysDate.weekday;
            int daysToAdd = difference > 0 ? difference : 7 + difference;
            Navigator.of(context).pop(
              todaysDate.add(Duration(days: daysToAdd)),
            );
          }
        },
        {
          'label': 'After 1 week',
          'isSelected': (DateTime? selectedDate) {
            return selectedDate == todaysDate.add((const Duration(days: 7)));
          },
          'callback': () {
            Navigator.of(context).pop(todaysDate.add(const Duration(days: 7)));
          }
        },
      ]
    ];
  } else {
    entries = [
      [
        {
          'label': 'No Date',
          'isSelected': (DateTime? selectedDate) {
            return selectedDate == null;
          },
          'callback': () {
            Navigator.of(context).pop();
          }
        },
        {
          'label': 'Today',
          'isSelected': (DateTime? selectedDate) {
            return selectedDate == todaysDate;
          },
          'callback': () {
            Navigator.of(context).pop(todaysDate);
          }
        },
      ]
    ];
  }

  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 24,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: double.infinity),
                  ...entries.map((entry) {
                    return Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(entry.length, (index) {
                            final bool isSelected = entry[index]
                                ['isSelected'](selectedDate) as bool;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  entry[index]['callback']();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 7,
                                  ),
                                  margin: EdgeInsets.only(
                                    right: index == 0 ? 8 : 0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: isSelected
                                        ? AppTheme.blueDark
                                        : AppTheme.blueLight,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    entry[index]['label'] as String,
                                    style: AppTheme.bodyMedium.copyWith(
                                      color: isSelected
                                          ? Colors.white
                                          : AppTheme.blueDark,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 16)
                      ],
                    );
                  }),
                  TableCalendar(
                    calendarController: calendarController,
                    initialSelectedDay: selectedDate,
                    simpleSwipeConfig: const SimpleSwipeConfig(
                      verticalThreshold: double.infinity,
                    ),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonVisible: false,
                      titleTextStyle: AppTheme.headingLarge.copyWith(
                        color: AppTheme.lightBlack,
                      ),
                      leftChevronIcon: const Icon(
                        Icons.arrow_left_rounded,
                        size: 35,
                        color: AppTheme.greyDark,
                      ),
                      rightChevronIcon: const Icon(
                        Icons.arrow_right_rounded,
                        size: 35,
                        color: AppTheme.greyDark,
                      ),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: AppTheme.headingSmall.copyWith(
                        color: AppTheme.lightBlack,
                      ),
                      weekendStyle: AppTheme.headingSmall.copyWith(
                        color: AppTheme.lightBlack,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      weekdayStyle: AppTheme.headingSmall.copyWith(
                        color: AppTheme.lightBlack,
                      ),
                      weekendStyle: AppTheme.headingSmall.copyWith(
                        color: AppTheme.lightBlack,
                      ),
                      outsideDaysVisible: false,
                      highlightToday: true,
                      highlightSelected: true,
                      todayStyle: AppTheme.headingSmall.copyWith(
                        color: AppTheme.blueDark,
                      ),
                      todayColor: Colors.white,
                      selectedColor: AppTheme.blueDark,
                      selectedStyle: AppTheme.headingSmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    builders: CalendarBuilders(
                      todayDayBuilder: (context, date, _) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.blueDark, // Border color
                              width: 2, // Border thickness
                            ),
                          ),
                          child: Text(
                            '${date.day}',
                            style: AppTheme.headingSmall.copyWith(
                              color: AppTheme.blueDark, // Text color for today
                            ),
                          ),
                        );
                      },
                      selectedDayBuilder: (context, date, _) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.blueDark,
                          ),
                          child: Text(
                            '${date.day}',
                            style: AppTheme.headingSmall.copyWith(
                              color: Colors.white, // Text color for today
                            ),
                          ),
                        );
                      },
                      dayBuilder: (context, date, _) {
                        bool isDisabled=true;
                        if(!isJoiningDate){
                          isDisabled = date.isBefore(selectedDate!);
                        }else{
                          isDisabled=false;
                        }
                        return Container(
                          margin: const EdgeInsets.all(6),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent, // Gray background for disabled dates
                          ),
                          child: Text(
                            '${date.day}',
                            style: !isJoiningDate?AppTheme.headingSmall.copyWith(
                              color: isDisabled ? AppTheme.greyDark : AppTheme.lightBlack, // Gray for disabled, default for others
                            ):AppTheme.headingSmall.copyWith(
                              color: AppTheme.lightBlack, // Gray for disabled, default for others
                            ),
                          ),
                        );
                      },

                    ),
                    onDaySelected: (day, events, holidays) {
                      if(!isJoiningDate){
                        if (day.isBefore(selectedDate!)) {
                          return; // Ignore selection for past dates
                        }
                        setState(() {
                          day = day.toLocal();
                          selectedDate = DateTime(day.year, day.month, day.day);
                        });
                      }else{
                        setState(() {
                          day = day.toLocal();
                          selectedDate = DateTime(day.year, day.month, day.day);
                        });
                      }

                    },
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: AppTheme.greyLight),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.event,
                            color: AppTheme.blueDark,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            selectedDate == null
                                ? 'No Date'
                                : DateFormat('d MMM y').format(selectedDate!),
                            style: AppTheme.bodyLarge.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppTheme.lightBlack,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.blueLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: AppTheme.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.blueDark,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop(selectedDate);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 21,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.blueDark,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Save',
                                style: AppTheme.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
