import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDatePicker{

  static Future<DateTime?> show({required DateTime initialDate, required BuildContext context}) async {
    DateTime? dateSelection;
    await showDialog(context: context, builder: (context){
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                height: MediaQuery.of(context).size.height * 0.08,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: const [
                    Icon(Icons.calendar_today, color: Colors.white),
                    SizedBox(width: 5,),
                    Text("Selecionar data", style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CalendarDatePicker(
                    initialDate: initialDate,
                    firstDate: DateTime(DateTime.now().year - 2),
                    lastDate: DateTime(DateTime.now().year + 2),
                    onDateChanged: (date){
                      dateSelection = date;
                      Get.back();
                    }
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                    onTap: () => Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 3, right: 10),
                      child: Text("Cancelar", textAlign: TextAlign.right, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),),
                    )),
              )
            ],
          ),
        ),
      );
    });

    return dateSelection;
  }
}