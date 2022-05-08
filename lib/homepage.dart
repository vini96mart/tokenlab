import 'package:flutter/material.dart';
import 'network.dart';
import 'details.dart';

//Aqui teremos a homepage, com a lista de filmes a ser mostrada.

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Movies')),
      body: Container(
        child: FutureBuilder(
          future: fetchFilme(),                                     //Aplica a função fetch para os filmes encontrada em 'network.dart'
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.hasData){                                  //A página será mostrada caso snapshots montados no futurebuilder tiver dados
              return ListView.builder(                              //Construtor de um ListView para os filmes
                itemCount: snapshot.data?.length ?? 0,              //Conta o número de filmes da lista, no caso, 20
                itemBuilder: (BuildContext context, int index){     //Monta a lista de acordo com os filmes encontrados (index)
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        snapshot.data[index].posterUrl              //Avatar com foto do poster do filme
                      ),
                    ),
                    title: Text(snapshot.data[index].title),        //Mostra título do filme e a média como subtítulo
                    subtitle: Text(snapshot.data[index].voteAverage.toString()),
                    onTap: (){  
                      Navigator.push(context,
                      new MaterialPageRoute(builder: (context)      //Ao tocar no filme escolhido, abre a página de detalhes, encontrada em 'details.dart'
                      => Details(snapshot.data[index])));
                    },
                  );
                }
              );
            } else if (snapshot.hasError){                          //Caso os snapshots não tiverem dados, vai para mensagem de erro
              return Container(
                child: Center(
                  child: Text('Dados não encontrados!')),
                  );
            } else{                                                 //Caso o futurebuilder não der certo, sem mensagem de erro, apenas
              return Container(                                     //sinaliza busca
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}