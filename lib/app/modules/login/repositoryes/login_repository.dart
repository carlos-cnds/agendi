

import 'dart:convert';

import 'package:agendi/models/response.dart';
import 'package:agendi/models/user.dart';
import 'package:agendi/shared/constants.dart';
import 'package:agendi/shared/repositories/user_local_repository.dart';
import 'package:agendi/shared/utils/email.dart';
import 'package:crypto/crypto.dart';
import 'package:mysql1/mysql1.dart';
import 'package:random_password_generator/random_password_generator.dart';

class LoginRepository{



  static Future<RequestResponse> login({required String email, required String password}) async {

    try{
         var conn = await MySqlConnection.connect(sqlSettings);
      
      String passMd5 = md5.convert(utf8.encode(password)).toString();

      // validar usuário cadastrado
      var results = await conn.query('SELECT * from user WHERE email = ? and password = ?', ['$email', '$passMd5']);

      if(results.isEmpty){
        return RequestResponse(isSuccess: false, message: 'Email ou senha incorretos!');
      }

      var isValid = true;
      var userId = 0;

      results.forEach((row){
        userId = row['id'];
        if(row['active'] == false){
          isValid = false;
        }
      });

      if(!isValid){
        return RequestResponse(isSuccess: false, message: 'Sua conta ainda não foi ativada! Eviamos um link de ativação para seu e-mail');
      }
      
      UserLocalRepository.updateLocal(User(email: email, passMd5: passMd5, id: userId));
      return RequestResponse(isSuccess: true, message: 'Login com sucesso');
      

    }catch(e){
      return RequestResponse(isSuccess: false, message: 'Ocorreu algum erro. Pedimos desculpas pelo incoveniente.');
    }
  }

  static Future<bool> resetPassword({required String email}) async {

    try{

      var conn = await MySqlConnection.connect(sqlSettings);
      
      final password = RandomPasswordGenerator();

      String newPassword = password.randomPassword(letters: true, numbers: true, uppercase: true, specialChar: false);

      String passMd5 = md5.convert(utf8.encode(newPassword)).toString();

      // validar usuário cadastrado
      await conn.query('UPDATE user SET password = ? WHERE email = ?', ['$passMd5', '$email']);

      await Email.sendInfoResetPassword(email: email, newPassword: newPassword);

      UserLocalRepository.updateLocal(User(email: email, passMd5: newPassword));
  
      return true;

    }catch(e){
      return false;
    }
  }

}