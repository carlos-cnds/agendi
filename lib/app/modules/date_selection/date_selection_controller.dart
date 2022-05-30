
import 'package:agendi/models/task.dart';
import 'package:agendi/shared/repositories/task_repository.dart';
import 'package:get/get.dart';

class DateSelectionController extends GetxController{


  var currentDate = DateTime.now();
  var selectedDate = DateTime.now().obs;

  DateSelectionController(DateTime selectedDate){
    this.selectedDate.value = selectedDate;
    taskList.value = TaskRepository.getTaskFromDate(date: selectedDate);
  }

  
  var taskList = <Task>[].obs;



}