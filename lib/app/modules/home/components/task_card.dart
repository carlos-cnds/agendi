import 'package:agendi/models/task.dart';
import 'package:agendi/shared/constants.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final bool isFirst;
  final bool isLast;
  const TaskCard({Key? key, required this.task, required this.isFirst, required this.isLast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (task.contact! == "" && task.value! == 0) ? MediaQuery.of(context).size.height * 0.12 : MediaQuery.of(context).size.height * 0.18,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 22,
                  color: GRAYCOLOR2,
                ),
                SizedBox(
                  width: 3,
                ),
                Column(
                  children: [
                    Visibility(
                      visible: !isFirst,
                      child: Container(
                        width: 10,
                        height: 5,
                        decoration: BoxDecoration(
                            color: WHITE_OPACITY2,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      ),
                    ),
                    Expanded(
                      child: Container(width: 1,
                        color: WHITE_OPACITY2,
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "${DateFormat("HH:mm").format(task.begin!)}",
                            style: TextStyle(
                                color: GRAYCOLOR2,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "${DateFormat("HH:mm").format(task.end!)}",
                            style: TextStyle(
                                color: WHITE_OPACITY2,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(width: 1,
                        color: WHITE_OPACITY2,
                      ),
                    ),
                    Visibility(
                      visible: !isLast,
                      child: Container(
                        width: 10,
                        height: 5,
                        decoration: BoxDecoration(
                            color: WHITE_OPACITY2,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(left: 3, right: 3),
                    child: Icon(
                      Icons.more_horiz,
                      size: 12,
                      color: WHITE_OPACITY2,
                    )),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Color(0xff21283E).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5),
                  ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${task.description!}',
                          style: TextStyle(color: WHITE_OPACITY2),
                        ),
                        Visibility(
                          visible: task.client! != "",
                          child: Text(
                            ' - ${task.client ?? ""}',
                            style: TextStyle(color: WHITE_OPACITY2),
                          ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: task.contact! != "" || task.value! != 0,
                      child: Row(
                        children: [
                          Expanded(
                            child: Visibility(
                              visible: task.contact! != "",
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: InkWell(
                                      child: Icon(
                                        Icons.phone,
                                        color: WHITE_OPACITY2,
                                      ),
                                      onTap: () async {
                                        await launch("tel:${task.contact!}");
                                      },
                                    ),
                                  ),
                                  InkWell(
                                    child: Icon(
                                      Icons.whatsapp,
                                      color: Color(0xff7a7a7a),
                                    ),
                                    onTap: () async {
                                      String phone = task.contact!;
                                      if(!phone.startsWith('+55')){
                                        phone = '+55' + phone;
                                      };

                                      await launch("https://wa.me/${phone}");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            NumberFormat.currency(symbol: 'R\$', locale: 'pt', decimalDigits: 2).format(task.value!),
                            style: TextStyle(fontWeight: FontWeight.w600, color: WHITE_OPACITY2),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
