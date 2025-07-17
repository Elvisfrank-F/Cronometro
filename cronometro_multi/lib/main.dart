import 'package:flutter/material.dart';
import 'home_page.dart';

void main() => runApp(Cronometro());

class Cronometro extends StatelessWidget{

  const Cronometro({super.key});

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      title: 'cronometro',
      theme: ThemeData.dark(),
      home:HomePage()
    );
  }
}