import 'package:agendi/app/modules/login/login_controller.dart';
import 'package:agendi/shared/components/alert_message.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Image.asset(
                    'assets/images/agendi_branco.png',
                    width: 150,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).primaryColor,
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white),
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 40),
                      child: Column(
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            return TextField(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "e-mail"),
                              keyboardType: TextInputType.emailAddress,
                              controller: controller.emailController.value,
                            );
                          }),
                          SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            return TextField(
                              obscureText: !controller.passIsVisible.value,
                              controller: controller.passwordController,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: controller.passIsVisible.value
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onPressed: () {
                                      controller.passIsVisible.value =
                                          !controller.passIsVisible.value;
                                    },
                                  ),
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: "senha"),
                            );
                          }),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 42,
                            child: Obx(() {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: controller.isLoading.value == true
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      )
                                    : Text("Entrar"),
                                onPressed: () async {
                                  if(controller.isLoading.value == true){
                                    return;
                                  }
                                  FocusScope.of(context).requestFocus();
                                  var response = await controller.login();
                                  
                                  if(!response.isSuccess!){
                                    await CustomAlertMessage.show(context: context, message: response.message!, type: MESSAGE_TYPE.ERROR);
                                    return;
                                  }

                                  Get.offAndToNamed('/home');
                                },
                              );
                            }),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                child: Text(
                                  "Criar conta",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor),
                                ),
                                onPressed: () {
                                  Get.toNamed('/create_account');
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "Esqueci a senha",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor),
                                ),
                                onPressed: () async {
                                  if(controller.emailController.value.text.isEmpty){
                                    await Fluttertoast.showToast(msg: "Informe seu email");
                                    return;
                                  }
                                  showDialog(
                                    context: context,
                                     builder: (context){
                                       return AlertDialog(
                                         content: Text("Eviaremos um email com uma nova senha para '${controller.emailController.value.text}'"),
                                         actions: [
                                           TextButton(
                                             child: Text("Cancelar"),
                                             onPressed: ()=> Get.back(),
                                           ),
                                           TextButton(
                                             child: Text("Confirmar"),
                                             onPressed: (){
                                               controller.resetPassword();
                                               Get.back();
                                             },
                                           )
                                         ],
                                       );
                                     });
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
