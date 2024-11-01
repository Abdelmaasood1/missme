import 'package:flutter/material.dart';

class MyDateUtil{
  static String getFormattedTime(BuildContext context, DateTime time){
    final formattedTime = TimeOfDay.fromDateTime(time).format(context);
    return formattedTime;
  }
}