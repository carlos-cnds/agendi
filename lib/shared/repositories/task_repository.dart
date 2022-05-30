

import 'package:agendi/models/task.dart';
import 'package:agendi/shared/constants.dart';
import 'package:agendi/shared/repositories/user_local_repository.dart';
import 'package:hive/hive.dart';
import 'package:mysql1/mysql1.dart';

class TaskRepository{


  static Future<List<Task>> getTasks() async {

    try{

      var conn = await MySqlConnection.connect(sqlSettings);

      // validar usuário cadastrado
      var results = await conn.query('SELECT * from tasks WHERE user_id = ?', [UserLocalRepository.getUser()!.id]);

      List<Task> tasks = [];

      results.forEach((row){
        tasks.add(Task(
          id: row['id'],
          begin: row['data_inicio'],
          end: row['data_fim'],
          client: row['cliente'],
          description: row['tarefa'],
          contact: row['contato'],
          value: row['valor'],
          userId: row['user_id']
        ));
      });

      updateTasksLocal(tasks);
      return tasks;

    }catch(e){
      print(e);
      return getTaksLocal();
    }

  }

  static void updateTasksLocal(List<Task> tasks) async {
    final taskBox = Hive.box('task');
    taskBox.put('task_key', tasks.map((e) => e.toJson()).toList());
  }

  static List<Task> getTaksLocal(){
    var item = Hive.box('task').get('task_key');
    if(item == null) return [];
    List<Task> listTask = [];
    item.forEach((t){
      listTask.add(Task.fromJson(t.cast<String, dynamic>()));
    });
    return listTask;
  }

  static List<Task> getTaskFromDate({required DateTime date}){
    var listAll = getTaksLocal();
    var listFilter = listAll.where((t) => t.begin!.day == date.day && t.begin!.month == date.month && t.begin!.year == date.year).toList();
    listFilter.sort((a, b) => a.begin!.compareTo(b.begin!));
    return listFilter;
  }

}