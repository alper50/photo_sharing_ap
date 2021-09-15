import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static final ThemeData lightheme = ThemeData(
    bottomSheetTheme: BottomSheetThemeData(

      backgroundColor: Colors.white.withOpacity(0),
      elevation: 13,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.brown,
        backgroundColor: Colors.green,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    ),
    fontFamily: "Asap",
    brightness: Brightness.light,
    accentColor: Colors.greenAccent,
    cardTheme: CardTheme(
      elevation: 3.0,
      shadowColor: Colors.grey[50],
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 25.0,
    ),
    primaryColor: Colors.green[400],
    secondaryHeaderColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.green[400],
      // textTheme: TextTheme(
      //   // ignore: deprecated_member_use
      //   title: TextStyle(
      //     color: Colors.black,
      //     fontSize: 21.0,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
    ),
    tabBarTheme: TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.red, width: 3.0),
      ),
      labelPadding: EdgeInsets.only(
        right: 5.0,
        left: 10.0,
      ),
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black38,
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black38,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.grey.shade50,
      splashColor: Colors.grey[300],
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        color: Colors.grey,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
    ),
  );
}
