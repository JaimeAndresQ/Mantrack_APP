import 'package:flutter/material.dart';


class TAppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: false,
    primaryColor: Colors.blueAccent,
    fontFamily: "Schyler",
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black54),
      bodySmall: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)
      
    )
    );


  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: false,

    primaryColor: const Color.fromARGB(255, 14, 50, 112),
    fontFamily: "Schyler"

    );
}
