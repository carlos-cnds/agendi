


import 'package:agendi/models/task.dart';
import 'package:agendi/models/user.dart';
import 'package:agendi/shared/constants.dart';
import 'package:agendi/shared/repositories/user_local_repository.dart';
import 'package:mysql1/mysql1.dart';

class DateSelecionRepository{



  static Future<List<Task>?> getTaksForUser() async {

    User? user = UserLocalRepository.getUser();

    try{
      var conn = await MySqlConnection.connect(sqlSettings);
      
      // validar usuário cadastrado
      var results = await conn.query('SELECT * from tasks WHERE user_id = ?', ["${user!.id ?? 0}"]);

      results.forEach((row){
      
        
      });
    }catch(e){
      return null;
    }

  }

}