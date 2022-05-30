import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

Map<int, Color> COLOR_PRIMARY =
{
  50: const Color.fromRGBO(24,29,49, .1),
  100:const Color.fromRGBO(24,29,49, .2),
  200:const Color.fromRGBO(24,29,49, .3),
  300:const Color.fromRGBO(24,29,49, .4),
  400:const Color.fromRGBO(24,29,49, .5),
  500:const Color.fromRGBO(24,29,49, .6),
  600:const Color.fromRGBO(24,29,49, .7),
  700:const Color.fromRGBO(24,29,49, .8),
  800:const Color.fromRGBO(24,29,49, .9),
  900:const Color.fromRGBO(24,29,49, 1),
};

const Color GRAYCOLOR1 = Color(0xff505050);
Color GRAYCOLOR2 = Color(0xff6272A4).withOpacity(0.6);
Color WHITE_OPACITY1 = Colors.white.withOpacity(0.4);
Color WHITE_OPACITY2 = Colors.white.withOpacity(0.2);
const Color PURPLECOLOR1 = Color(0xffB536B8);


var  sqlSettings = ConnectionSettings(
  host: 'csdnapps.com',
  port: 3306,
  user: 'csdnap99_Edinis',
  password: 'Cevs150289\$',
  db: 'csdnap99_agendi'
);

const DAY_OF_WEEK = {
 1 : 'Segunda Feira',
 2 : 'Terça Feira',
 3 : 'Quarta Feira',
 4 : 'Quinta Feira',
 5 : 'Sexta Feira',
 6 : 'Sábado',
 7 : 'Domingo',
};