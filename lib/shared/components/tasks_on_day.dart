import 'package:agendi/models/task.dart';
import 'package:agendi/shared/repositories/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaksOnDay extends StatelessWidget {
  final DateTime date;
  const TaksOnDay({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;
    List<Task> taskList = TaskRepository.getTaskFromDate(date: date);
    return Column(
      children: taskList
          .map((task) => Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: primary, width: .5),
                    borderRadius: BorderRadius.circular(5),
                    color: primary.withOpacity(0.1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: primary,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${DateFormat("HH:mm").format(task.begin!)} - ${DateFormat("HH:mm").format(task.end!)}',
                          style: TextStyle(
                              color: primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '${task.description!}',
                          style: TextStyle(color: primary, fontSize: 12),
                        ),
                        Visibility(
                          visible: task.client! != "",
                          child: Text(
                            ' - ${task.client ?? ""}',
                            style: TextStyle(color: primary, fontSize: 12),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))
          .toList(),
    );
  }
}
