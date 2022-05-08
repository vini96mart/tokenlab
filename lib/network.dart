import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'filmemodel.dart';
import 'filmedetails.dart';
import 'package:http/http.dart' as http;

//Funções para puxar as informações dos API's oferecidos

Future<List<FilmeModel>> fetchFilme() async { //Função para puxar a lista de filmes
  final response = await http.get(Uri.parse('https://desafio-mobile.nyc3.digitaloceanspaces.com/movies'));
    
  if (response.statusCode == 200){
    final FilmeModel = FilmeModelFromJson(response.body);
    return FilmeModel;
  }
  else{
    throw Exception('Falha ao carregar filmes!');
  }
}

Future<FilmeDetalhes> fetchDetails(int? a) async {  //Função para puxar os detalhes de um filme específico
  String newUrl = 'https://desafio-mobile.nyc3.digitaloceanspaces.com/movies/$a'; //O valor 'a' é a id do filme escolhido pelo usuário
  final response = await http.get(Uri.parse(newUrl));
    
  if (response.statusCode == 200){
    final FilmeDetalhes = FilmeDetalhesFromJson(response.body);
    return FilmeDetalhes;
  }
  else{
    throw Exception('Falha ao carregar filme!');
  }
}