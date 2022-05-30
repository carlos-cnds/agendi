import 'package:agendi/app/modules/create_account/repositories/create_account_repository.dart';
import 'package:agendi/models/response.dart';
import 'package:agendi/shared/constants.dart';
import 'package:agendi/shared/utils/email.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:uuid/uuid.dart';


class CreateAccountController extends GetxController{


  var isLoading = false.obs;
  var passIsVisible = false.obs;
  var confirmPassIsVisible = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  Future<RequestResponse> createAccount() async {

    if(emailController.text.isEmpty){
      return RequestResponse(isSuccess: false, message: 'Informe um email.');
    }
    if(passController.text.isEmpty){
      return RequestResponse(isSuccess: false, message: 'Informe a senha.');
    }
    if(confirmPassController.text.isEmpty){
      return RequestResponse(isSuccess: false, message: 'Informe a confirmação da senha.');
    }
    if(confirmPassController.text != passController.text){
      return RequestResponse(isSuccess: false, message: 'As senhas digitadas não conferem');
    }
    if(passController.text.length < 6){
      return RequestResponse(isSuccess: false, message: 'A senha precisa ter no máximo 6 dígitos.');
    }
    isLoading.value = true;

    var uuid = Uuid();
    var token = uuid.v1();

    var resp = await CreateAccoutRepository.createAccount(email: emailController.text, password: passController.text, token: token, expirationDate: DateTime.now().add(Duration(hours: 2)));
    

    if(resp.isSuccess!){
      
     await Email.sendLinkToEmail(email: emailController.text, token: token);

    }

    isLoading.value = false;
    return resp;
  }
  

}