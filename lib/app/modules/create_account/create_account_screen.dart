import 'package:agendi/app/modules/create_account/create_account_controller.dart';
import 'package:agendi/app/modules/login/login_controller.dart';
import 'package:agendi/shared/components/alert_message.dart';
import 'package:agendi/shared/utils/email.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CreateAccountController controller = Get.put(CreateAccountController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/agendi_cinza.png',
                width: 150,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email), hintText: "e-mail"),
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailController,
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() {
              return TextField(
                obscureText: !controller.passIsVisible.value,
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
                controller: controller.passController,
              );
            }),
            SizedBox(
              height: 20,
            ),
            Obx(() {
              return TextField(
                obscureText: !controller.confirmPassIsVisible.value,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: controller.confirmPassIsVisible.value
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        controller.confirmPassIsVisible.value =
                            !controller.confirmPassIsVisible.value;
                      },
                    ),
                    prefixIcon: Icon(Icons.lock),
                    hintText: "confirmar senha"),
                controller: controller.confirmPassController,
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
                          borderRadius: BorderRadius.circular(20))),
                  child: controller.isLoading.value == true
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                        )
                      : Text("Criar"),
                  onPressed: () async {

                    if (controller.isLoading.value) {
                      return;
                    }
                    var response = await controller.createAccount();

                    if (!response.isSuccess!) {
                      await CustomAlertMessage.show(
                          context: context,
                          message: response.message!,
                          type: MESSAGE_TYPE.ERROR);

                      return;
                    }

                    await CustomAlertMessage.show(
                          context: context,
                          message: "Conta criada com sucesso! Enviamos um link de ativação para o seu email.",
                          type: MESSAGE_TYPE.SUCCESS);

                    LoginController loginController = Get.put(LoginController());
                    loginController.emailController.value.text = controller.emailController.text;
                    Get.back();

                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
