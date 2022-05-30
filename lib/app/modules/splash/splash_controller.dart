



import 'package:agendi/app/modules/home/home_screen.dart';
import 'package:agendi/app/modules/login/login_screen.dart';
import 'package:agendi/shared/repositories/user_local_repository.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{

  SplashController(){
    gotoLocation();
  }

  void gotoLocation() async {
    var user = UserLocalRepository.getUser();
    await Future.delayed(Duration(seconds: 2));
    if(user!.id == null){
      Get.off(LoginScreen());
    }else{
      Get.off(HomeScreen());
    }
    
  }

}