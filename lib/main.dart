import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'network.dart';
import 'homepage.dart';
import 'details.dart';

//A página principal para execução do aplicativo

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tokenlab',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),   //executa a classe HomePage encontrada em 'homepage.dart'
    );
  }
}