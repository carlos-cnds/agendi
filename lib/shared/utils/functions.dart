

import 'package:agendi/shared/constants.dart';

class Functions{


  static double stringDoubleToDouble(String value)
  {
    // Caso tenha ponto e virgula na mesma string
    if(value.indexOf('.', 0) >= 0 && value.indexOf(',', 0) >= 0)
    {
      var values = value.split(',');

      if(double.parse(values[1]) == 0)
      {
        return double.parse(values[0].replaceAll('.', ''));
      }
      else
      {
        String d = values[0].replaceAll('.', '');
        d +=  "." + values[1];
        return double.parse(d);

      }

    }
    else
    {
      return double.parse(value.toString().replaceAll(',', '.'));
    }
  }

  static String getDayOfWeek(DateTime date){
    var currDate = DateTime.now();
    if(date.year == currDate.year && date.day == currDate.day && date.month == currDate.month){
      return "Hoje";
    }

    return DAY_OF_WEEK[date.weekday]!;

  }
  
}