import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomAlertMessage{

  static Future<void> show({required BuildContext context, required String message, required MESSAGE_TYPE type, String? title, Widget? contentWidget}) async {
    await showDialog(context: context, builder: (context) {

      IconData _icon;
      Color _color;

      if(title == null || title == ""){
        if(type == MESSAGE_TYPE.INFO){
          title = "Informação";
        }else if(type == MESSAGE_TYPE.ALERT){
          title = "Alerta";
        }else if(type == MESSAGE_TYPE.SUCCESS){
          title = "Sucesso!";
        }
        else if(type == MESSAGE_TYPE.NO_INTERNET){
          title = "Aviso!";
        }
        else{
          title = "OPs!";
        }
      }

      if(type == MESSAGE_TYPE.INFO){
        _icon = Icons.info;
        _color = Colors.blueAccent;
      }else if(type == MESSAGE_TYPE.ALERT){
        _icon = Icons.warning;
        _color = Colors.deepOrangeAccent;
      }else if(type == MESSAGE_TYPE.SUCCESS){
        _icon = Icons.check_circle;
        _color = Colors.green;
      }else if(type == MESSAGE_TYPE.NO_INTERNET){
        _icon = Icons.wifi_off_outlined;
        _color = Colors.redAccent;
      }
      else{
        _icon = Icons.warning;
        _color = Colors.red;
      }

      Widget _getMessageWidget(){
        if(contentWidget == null){
          return Text(message, style: TextStyle(fontSize: 12), textAlign: TextAlign.center,);
        }else{
          return contentWidget;
        }
      }

      return AlertDialog(
        contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
        title:  Text(title ?? ""),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(_icon, size: 35, color: _color,),
              SizedBox(height: 10,),
              _getMessageWidget()
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text("OK", style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),),
            onPressed: () => Get.back(),
          )
        ],
      );
    });
  }
}


enum MESSAGE_TYPE{
  SUCCESS,
  INFO,
  ALERT,
  ERROR,
  NO_INTERNET
}