


import 'package:agendi/models/task.dart';
import 'package:agendi/shared/repositories/task_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  HomeController(){
    getData();
  }
  var currentDate = DateTime.now().obs;
  var taskList = <Task>[].obs;

  void getData(){
    TaskRepository.getTasks();
    taskList.value = TaskRepository.getTaskFromDate(date: currentDate.value);
  }

  void nextDate(){
    currentDate.value = currentDate.value.add(Duration(days: 1));
    taskList.value = TaskRepository.getTaskFromDate(date: currentDate.value);
  }

  void previousDate(){
    currentDate.value = currentDate.value.add(Duration(days: -1));
    taskList.value = TaskRepository.getTaskFromDate(date: currentDate.value);
  }

}