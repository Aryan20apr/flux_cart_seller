import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkThemeData=ThemeData(
  primarySwatch: Colors.deepPurple,
  primaryColorLight: Colors.purpleAccent,
  primaryColorDark: Colors.purple,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  //********************** Tab bar Theme**************************
  tabBarTheme: TabBarTheme(
   /* indicatorColor: Colors.white,
    indicatorWeight: 2.0,
    indicatorPadding: EdgeInsets.zero,*/
    indicatorSize: TabBarIndicatorSize.label,
    indicator: BoxDecoration(),
    labelColor: Colors.white,
    labelStyle: TextStyle(),
    labelPadding: EdgeInsets.only(top: 10.0),
    unselectedLabelColor: Colors.grey,
    unselectedLabelStyle: TextStyle(),
    // overlayColor: Colors
  ),
    //************************* Outliined Button Theme**************
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey.withOpacity(0.8),width: 1.0)
        ),

        ),
  textTheme: TextTheme(
  titleLarge: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black)
  )

    );
