import 'package:flutter/material.dart';

import 'screen/classscreen.dart';
import 'screen/login.dart';
import 'screen/studentsscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: {
        '/login': (context) => Login(),
        '/students': (context) => StudentScreen(),
        '/class': (context) => ClasseScreen(),
        //'/formation': (context) => FormationScreen()
      },
    );
  }
}
