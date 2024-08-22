import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_manager.dart';

abstract class ThemeManager{

  static ThemeData getAppTheme(){
    return ThemeData(
      scaffoldBackgroundColor: ColorManager.black,
      appBarTheme:const AppBarTheme(
        foregroundColor: Colors.white,
        elevation: 0,
        color: ColorManager.black,
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.black,
        ),
      ),
    );
  }

}