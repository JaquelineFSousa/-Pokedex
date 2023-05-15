import 'package:flutter/material.dart';
//import 'package:pokedex/paginas/pokemon_info/pokemon_info.dart';

//import 'paginas/pokemon_list/pokemon_list.dart';
//import 'package:pokedex/paginas/pokemon_list/pokemon_list.dart';
import 'package:pokedex/paginas/home/widgets/home_page.dart';
//import 'package:pokedex/pagina/sandbox.dart';

void main() {
  runApp(const MyApp());
}

//inicio
class MyApp extends StatelessWidget {
  const MyApp({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: ThemeData(primaryColor: Colors.blue),
  
       home: const HomePage(),
     
     
    );
  }
}
