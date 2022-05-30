import 'dart:io';

import 'package:agendi/app/modules/create_account/create_account_screen.dart';
import 'package:agendi/app/modules/date_selection/date_selection_screen.dart';
import 'package:agendi/app/modules/home/home_screen.dart';
import 'package:agendi/app/modules/splash/splash_screen.dart';
import 'package:agendi/app/modules/task_detail/task_detail_screen.dart';
import 'package:agendi/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {

WidgetsFlutterBinding.ensureInitialized();

  Directory appDocDir = await path_provider.getApplicationDocumentsDirectory();
  Hive..init(appDocDir.path);
  await Hive.openBox("user");
  await Hive.openBox("task");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Agendi',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: MaterialColor(0xff181D31, COLOR_PRIMARY),
        textTheme: const TextTheme(
          headline1: TextStyle(color: GRAYCOLOR1),
          headline6: TextStyle(color: GRAYCOLOR1),
          bodyText2: TextStyle(color: GRAYCOLOR1),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: Color(0xffcecece)),
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.only(top: 0, bottom: 0, left: 10),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Color(0xffEBEBEB), width: 2)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const  BorderSide(color: Color(0xff181D31), width: 2)
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const  BorderSide(color: Color(0xff181D31), width: 2)
          ),
          suffixStyle: const TextStyle(color: Color(0xffEBEBEB)),
          labelStyle: const TextStyle(color: Color(0xffEBEBEB)),
          prefixStyle: const  TextStyle(color: Color(0xffEBEBEB)),
        ),
        buttonTheme: ButtonThemeData(
          shape: CircleBorder(
            side: BorderSide()
          )
        ),
      ),
      initialRoute: '/splash',
      localizationsDelegates: [
       GlobalMaterialLocalizations.delegate,
       GlobalWidgetsLocalizations.delegate,
       GlobalCupertinoLocalizations.delegate,
     ],
     supportedLocales: [Locale("pt")],
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/create_account', page: () => CreateAccountScreen()),
        GetPage(name: '/task_detail', page: () => TaskDetailScreen()),
        GetPage(name: '/date_selection', page: () => DateSelectionScreen(currentDate: Get.arguments['currentDate'], onDateSelect: Get.arguments['onDateSelect'],))
      ],
    );
  }
}
