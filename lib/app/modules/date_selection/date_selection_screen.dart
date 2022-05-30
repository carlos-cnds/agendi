import 'package:agendi/app/modules/date_selection/date_selection_controller.dart';
import 'package:agendi/shared/components/tasks_on_day.dart';
import 'package:agendi/shared/constants.dart';
import 'package:agendi/shared/repositories/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DateSelectionScreen extends StatelessWidget {
  final DateTime currentDate;
  final Function(DateTime date)  onDateSelect;
  const DateSelectionScreen({Key? key, required this.currentDate, required this.onDateSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateSelectionController controller =
        Get.put(DateSelectionController(currentDate));
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecionar Data"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.check),
        onPressed: (){
          onDateSelect(controller.selectedDate.value);
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return TableCalendar(
                focusedDay: controller.selectedDate.value,
                currentDay: controller.selectedDate.value,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false
                ),
                calendarBuilders:
                    CalendarBuilders(markerBuilder: (context, day, events) {
                  if (events.isEmpty) {
                    return null;
                  } else {
                    return Container(
                      padding: EdgeInsets.only(right: 5, left: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Theme.of(context).primaryColor),
                      child: Text(
                        events.length.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    );
                  }
                }, 
                defaultBuilder: (context, selectedDay, focusedDay) {
                  if (selectedDay.day == DateTime.now().day && selectedDay.month == DateTime.now().month) {
                    return Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).primaryColor)),
                        child: Text(
                          selectedDay.day.toString(),
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    );
                  }
                  return null;
                }
                ),
                daysOfWeekHeight: 25,
                firstDay: DateTime.now().add(Duration(days: -720)),
                lastDay: DateTime.now().add(Duration(days: 360)),
                locale: 'pt_BR',
                onDaySelected: (selectedDay, focusedDay) {
                  controller.selectedDate.value = focusedDay;
                  
                },
                eventLoader: (day) {
                  var taskList = TaskRepository.getTaskFromDate(date: day);
                  return taskList;
                },
              );
            }),
            SizedBox(height: 15,),
            Obx((){
              return Text("${DAY_OF_WEEK[controller.selectedDate.value.weekday]}", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black26, fontSize: 18),);
            }),
            SizedBox(height: 10,),
            Obx((){
              return TaksOnDay(date: controller.selectedDate.value);
            })
          ],
        ),
      ),
    );
  }
}
