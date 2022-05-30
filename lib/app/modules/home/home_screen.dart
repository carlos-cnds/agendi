import 'package:agendi/app/modules/home/components/custom_menu.dart';
import 'package:agendi/app/modules/home/components/task_card.dart';
import 'package:agendi/app/modules/home/home_controller.dart';
import 'package:agendi/shared/constants.dart';
import 'package:agendi/shared/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, left: 10, right: 10),
              child: Row(
                children: [
                  CustomMenu(onPress: (){},),
                  Expanded(
                    child: Center(
                      child: Image.asset('assets/images/agendi_branco.png', width: 100,),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8, right: 8, top: 5),
              padding: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xff21283E).withOpacity(0.5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: GRAYCOLOR2,
                      size: 45,
                    ),
                    padding: EdgeInsets.all(5),
                    onPressed: () => controller.previousDate(),
                  ),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: WHITE_OPACITY1,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          child: Text(
                            DateFormat("dd/MM/yyyy")
                                .format(controller.currentDate.value),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: WHITE_OPACITY1,
                                fontSize: 18),
                          ),
                          onTap: () => Get.toNamed('/date_selection', arguments: {
                            'currentDate': controller.currentDate.value,
                            'onDateSelect': (date) {
                              controller.currentDate.value = date;
                            }
                          }),
                        ),
                        SizedBox(width: 10),
                        Text(
                          Functions.getDayOfWeek(controller.currentDate.value),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: WHITE_OPACITY1,
                              fontSize: 12),
                        ),
                      ],
                    );
                  }),
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      color: GRAYCOLOR2,
                      size: 45,
                    ),
                    padding: EdgeInsets.all(5),
                    onPressed: () => controller.nextDate(),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  print('ops');
                   if (details.primaryVelocity! > 0) {
                    controller.previousDate();
                  } else if (details.primaryVelocity! < 0) {
                    controller.nextDate();
                  }
                },
                child: Obx(() {
                  if (controller.taskList.value.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.black26,
                          size: 40,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Não há agendamentos",
                          style: TextStyle(color: Colors.black26),
                        )
                      ],
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: controller.taskList.value.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        task: controller.taskList.value[index],
                        isFirst: index == 0,
                        isLast: index == (controller.taskList.value.length - 1),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PURPLECOLOR1,
        child: Icon(Icons.playlist_add),
        onPressed: () => Get.toNamed('/task_detail'),
      ),
    );
  }
}
