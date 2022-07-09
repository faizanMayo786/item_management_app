import 'package:flutter/material.dart';

import 'view/page/login_page.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory App',
      theme: ThemeData().copyWith(
        colorScheme: const ColorScheme.light(
          primary: Colors.purple,
          secondary: Colors.purple,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
  
}
