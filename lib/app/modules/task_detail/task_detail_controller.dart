import 'package:agendi/app/modules/task_detail/repositories/task_detail_repository.dart';
import 'package:agendi/models/response.dart';
import 'package:agendi/models/task.dart';
import 'package:agendi/shared/repositories/task_repository.dart';
import 'package:agendi/shared/repositories/user_local_repository.dart';
import 'package:agendi/shared/utils/functions.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:permission_handler/permission_handler.dart';

class TaskDetailController extends GetxController {
  var dateOfTask = DateTime.now().obs;
  var initTime = TextEditingController().obs;
  var endTime = TextEditingController().obs;
  var service = TextEditingController();
  var contactName = TextEditingController();
  var client = TextEditingController().obs;
  var value = MoneyMaskedTextController(decimalSeparator: ",", precision: 2, thousandSeparator: ".");
  var contactSelection = Contact().obs;
  var isLoadingContacts = false.obs;
  var isLoading = false.obs;

  var maskFormatterTime = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});

  List<Contact> contactsAll = [];
  var contacts = <Contact>[].obs;

  TaskDetailController() {
    
  }


  void getContacts() async {
    isLoadingContacts.value = true;
    await Permission.contacts.request();
    contactsAll = await ContactsService.getContacts();
    contacts.value = contactsAll;
    isLoadingContacts.value = false;
  }

  void findContact() {
    if(contactName.text.isEmpty){
      contacts.value = contactsAll;
    }
    List<Contact> contactsQuery = [];
    contactsQuery = contacts
        .where(
            (a) => a.displayName!.toLowerCase().contains(contactName.text.toLowerCase()))
        .toList();
    contacts.value = contactsQuery;
  }

  Future<RequestResponse> insertTask() async {
    isLoading.value = true;
    var response = await TaskDetailRepository.isertTask(task: Task(
      begin: getBeginDate(),
      end: getEndDate(),
      client: client.value.text,
      contact: contactSelection.value.phones == null ? "" : contactSelection.value.phones!.first.value,
      description: service.value.text,
      id: 0,
      userId: UserLocalRepository.getUser()!.id!,
      value: Functions.stringDoubleToDouble(value.value.text) 
    ));
    if(response.isSuccess!){
      await TaskRepository.getTasks();
    }
    isLoading.value = false;
    return response;
  }

  DateTime getBeginDate(){
    return DateTime.parse(DateFormat('yyyy-MM-dd').format(dateOfTask.value) + " " + initTime.value.text);
  }

  DateTime getEndDate(){
    return DateTime.parse(DateFormat('yyyy-MM-dd').format(dateOfTask.value) + " " + endTime.value.text);
  }

  Map<String, dynamic> validateForm(){

    if(initTime.value.text.isEmpty){
      return {'valid' : false, 'message' : 'Informe o horário de início'};
    }
    if(endTime.value.text.isEmpty){
      return {'valid' : false, 'message' : 'Informe o horário de fim'};
    }
    if(initTime.value.text.length != 5){
      return {'valid' : false, 'message' : 'Horário de início inválido'};
    }
    if(endTime.value.text.length != 5){
      return {'valid' : false, 'message' : 'Horário final inválido'};
    }
    DateTime initDate;
    DateTime endDate;
    try{
      initDate = getBeginDate();
    }catch(e){
      return {'valid' : false, 'message' : 'Horário de início inválido'};
    }
    try{
      endDate = getEndDate();
    }catch(e){
      return {'valid' : false, 'message' : 'Horário final inválido'};
    }
    if(initDate.isAfter(endDate)){
      return {'valid' : false, 'message' : 'Horário de início maior que o final'};
    }

    if(service.value.text.isEmpty){
      return {'valid' : false, 'message' : 'Informe a descrição do agendamento'};
    }

    return {'valid' : true, 'message' : ''};

  }

}
