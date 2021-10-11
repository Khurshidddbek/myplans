import 'package:flutter/material.dart';
import 'package:myplans/pages/home_page.dart';
import 'package:myplans/pages/register_page.dart';
import 'package:myplans/utils/const_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white38,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultPadding , vertical: defaultPadding * 1.2
              )
          )
      ),
      home: RegisterPage(),
      routes: {
        HomePage.id : (context) => HomePage(),
        RegisterPage.id : (context) => RegisterPage()
      },
    );
  }
}
