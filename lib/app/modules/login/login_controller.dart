

import 'package:agendi/app/modules/login/repositoryes/login_repository.dart';
import 'package:agendi/models/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{


  var isLoading = false.obs;
  var emailController = TextEditingController().obs;
  TextEditingController passwordController = TextEditingController();
  var passIsVisible = false.obs;
  var isLoadingResetPass = false.obs;

  Future<RequestResponse> login() async {
    isLoading.value = true;
    var response = await LoginRepository.login(email: emailController.value.text, password: passwordController.text);
    isLoading.value = false;
    return response;
  }
  
  Future<bool> resetPassword() async {
    isLoadingResetPass.value = true;
    bool resp = await LoginRepository.resetPassword(email: emailController.value.text);
    isLoadingResetPass.value = false;
    return resp;
  }
}