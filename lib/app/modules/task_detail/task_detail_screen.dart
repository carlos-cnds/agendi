import 'package:agendi/app/modules/home/home_controller.dart';
import 'package:agendi/app/modules/task_detail/components/time_selection.dart';
import 'package:agendi/app/modules/task_detail/task_detail_controller.dart';
import 'package:agendi/shared/components/alert_message.dart';
import 'package:agendi/shared/components/tasks_on_day.dart';
import 'package:agendi/shared/constants.dart';
import 'package:agendi/shared/repositories/task_repository.dart';
import 'package:agendi/shared/utils/functions.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskDetailController controller = Get.put(TaskDetailController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Agendi"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: GRAYCOLOR1,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    child: Text(
                      DateFormat("dd/MM/yyyy").format(controller.dateOfTask.value),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: GRAYCOLOR1,
                          fontSize: 18),
                    ),
                    onTap: () => Get.toNamed('/date_selection', arguments: {'currentDate' : controller.dateOfTask.value, 'onDateSelect' : (date){
                      controller.dateOfTask.value = date;
                    }}),
                  ),
                  SizedBox(width: 10),
                  Text(
                    Functions.getDayOfWeek(controller.dateOfTask.value),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xffCCCCCC),
                        fontSize: 14),
                  ),
                ],
              );
            }),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Horário Início",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      Obx(() {
                        return TextField(
                          controller: controller.initTime.value,
                          inputFormatters: [controller.maskFormatterTime],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "00:00",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.timer),
                                onPressed: () async {
                                  var time = await TimeSelection.getTime(
                                      context: context,
                                      initialTime:
                                          controller.initTime.value.text);
                                  if (time != null) {
                                    controller.initTime.value.text =
                                        "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                                  }
                                },
                              )),
                        );
                      }),
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.keyboard_arrow_left,
                        color: GRAYCOLOR1,
                        size: 20,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: GRAYCOLOR1,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Horário Fim",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      Obx(() {
                        return TextField(
                          controller: controller.endTime.value,
                          keyboardType: TextInputType.number,
                          inputFormatters: [controller.maskFormatterTime],
                          decoration: InputDecoration(
                              hintText: "00:00",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.timer),
                                onPressed: () async {
                                  var time = await TimeSelection.getTime(
                                      context: context,
                                      initialTime:
                                          controller.endTime.value.text);
                                  if (time != null) {
                                    controller.endTime.value.text =
                                        "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                                  }
                                },
                              )),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Descrição",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                TextField(
                  controller: controller.service,
                  maxLength: 50,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: "Ex. Corte cabelo, manicure...",
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cliente (Opcional)",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Obx(() {
                      return Expanded(
                        flex: 8,
                        child: TextField(
                          controller: controller.client.value,
                          enabled:
                              controller.contactSelection.value.displayName ==
                                  null,
                        ),
                      );
                    }),
                    SizedBox(
                      width: 3,
                    ),
                    ElevatedButton(
                      child: Icon(Icons.contact_phone),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              controller.getContacts();
                              return Container(
                                padding: EdgeInsets.all(10),
                                height:
                                    MediaQuery.of(context).size.height * 0.80,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Associar um contato",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff909090),
                                                fontWeight: FontWeight.w600)),
                                        InkWell(
                                          child: const Icon(
                                            Icons.close,
                                            color: Color(0xff909090),
                                            size: 30,
                                          ),
                                          onTap: () => Get.back(),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.search),
                                          labelText: "Buscar nome",
                                          counterText: ""),
                                      controller: controller.contactName,
                                      onChanged: (value) {
                                        controller.findContact();
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                      child: Obx(() {
                                        if (controller
                                            .isLoadingContacts.value) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (controller.contacts.value.isEmpty) {
                                          return Text("Sem resultados...");
                                        }
                                        return ListView(
                                          children: controller.contacts.value
                                              .map((contact) => InkWell(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .black12))),
                                                      padding: EdgeInsets.only(
                                                          top: 10, bottom: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons.person),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(contact
                                                                  .displayName!)
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            contact.phones!
                                                                .first.value
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black26,
                                                                fontSize: 11),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      controller.client.value
                                                              .text =
                                                          contact.displayName!;
                                                      controller
                                                          .contactSelection
                                                          .value = contact;
                                                      Get.back();
                                                    },
                                                  ))
                                              .toList(),
                                        );
                                      }),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                    )
                  ],
                ),
                Obx(() {
                  return Visibility(
                    visible:
                        controller.contactSelection.value.displayName != null,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          child: Text(
                            "Limpar contato",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          onTap: () {
                            controller.client.value.clear();
                            controller.contactSelection.value = Contact();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                })
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Valor (Opcional)",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                TextField(
                  controller: controller.value,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.save),
        onPressed: () async {
          if(controller.isLoading.value){
            return;
          }
          var validate = controller.validateForm();
          if(validate['valid'] == false){
            await CustomAlertMessage.show(context: context, message: validate['message'], type: MESSAGE_TYPE.ERROR);
            return;
          }
          var response = await controller.insertTask();
          if(!response.isSuccess!){
            await CustomAlertMessage.show(context: context, message: response.message!, type: MESSAGE_TYPE.ERROR);
            return;
          }

          await CustomAlertMessage.show(context: context, message: 'Agendamento efetuado com sucesso!', type: MESSAGE_TYPE.SUCCESS);
          HomeController homeController = Get.put(HomeController());
          homeController.getData();
          Get.back();

        },
      ),
    );
  }
}
