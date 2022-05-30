

import 'dart:convert';

import 'package:agendi/models/response.dart';
import 'package:agendi/shared/constants.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';

class CreateAccoutRepository{


  static Future<RequestResponse> createAccount({required email, required String password, required String token, required DateTime expirationDate}) async {

    try{

      var conn = await MySqlConnection.connect(sqlSettings);
      
      // verificar se o usuário já está cadastrado e se está ativo no bacno
      var results = await conn.query('SELECT * from user WHERE email = ?', ['$email']);

      if(results.isNotEmpty){
        return RequestResponse(isSuccess: false, message: 'Conta de email já cadastrada no agendi');
      }

      String passMd5 = md5.convert(utf8.encode(password)).toString();

      var response = await conn.query("insert into user (email,password) values(?,?)", ['$email', '$passMd5']);
      var userId = response.insertId;
      String dateFormatted = DateFormat('yyyy-MM-dd HH:mm:ss').format(expirationDate);
      await conn.query("insert into token (user_id, token, expirate_in) values(?,?,STR_TO_DATE(?, '%Y-%m-%d %H:%i:%s'))", ['${userId!}', '$token', '${dateFormatted}']);

      return RequestResponse(isSuccess: true, message: '');

    }catch(e){
      return RequestResponse(isSuccess: false, message: 'Ocorreu algum erro! Por favor tente novamente.');
    }

  }
  
}