import 'package:flutter/material.dart';

import 'package:pokedex/paginas/login/login_page.dart';


void main() {
  runApp(const MyApp());
}

//inicio
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: ThemeData(primaryColor: Colors.blue),
      home: const LoginPage(),
    );
  }
}
