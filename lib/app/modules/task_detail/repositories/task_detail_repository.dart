import 'package:agendi/models/response.dart';
import 'package:agendi/models/task.dart';
import 'package:agendi/shared/constants.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';



class TaskDetailRepository{



  static Future<RequestResponse> isertTask({required Task task}) async {
    try{
      
      var conn = await MySqlConnection.connect(sqlSettings);
      
      String initDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(task.begin!);
      String endDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(task.end!);
      var results = await conn.query('''INSERT INTO tasks SET 
      data_inicio = STR_TO_DATE(?, '%Y-%m-%d %H:%i:%s'),
      data_fim = STR_TO_DATE(?, '%Y-%m-%d %H:%i:%s'),
      cliente = ?, tarefa = ?, contato = ?, valor = ?, user_id = ?''',
       ['$initDate', '$endDate', '${task.client!}', '${task.description!}', '${task.contact!}', '${task.value!}', task.userId!]);


      if(results.insertId == null){
        return RequestResponse(isSuccess: false, message: 'Erro ao inserir');
      }else{
        return RequestResponse(isSuccess: true, message: '');
      }
      
    }catch(e){
      print(e);
      return RequestResponse(isSuccess: false, message: '');
    }
  }

}