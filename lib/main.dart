import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:removebg/route/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  bool isDarkThemeEnabled = false;

  @override
  Widget build(BuildContext context) {
    ThemeData lightTheme=ThemeData(
      focusColor:  Color(0xff168a72),
      scaffoldBackgroundColor: Colors.white,

    );
    ThemeData darkTheme=ThemeData(
      focusColor:  Colors.amber,
      scaffoldBackgroundColor: Colors.black12,

    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,

      getPages:
        Routes.myPages,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      // themeMode: isDarkThemeEnabled ? ThemeMode.dark : ThemeMode.light,
    );
  }
}

