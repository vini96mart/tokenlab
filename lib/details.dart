import 'package:flutter/material.dart';
import 'filmemodel.dart';
import 'network.dart';

//Esta é a página de detalhes, executada quando o usuário toca em um filme específico na homepage.

class Details extends StatelessWidget{
  final FilmeModel filme;
  
  Details(this.filme);  //A inicialização é feita com os dados da página anterior de acordo com o filme escolhido, a fim de fazer o fetch correto

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: SingleChildScrollView(                  //Scrollagem para baixo caso aconteça overflow de pixels
        child: Center(
          child: FutureBuilder(
            future: fetchDetails(this.filme.id),    //Aplica a função fetch para o filme específico encontrada em network.dart
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if (snapshot.hasData) {               //A página será mostrada caso snapshots montados no novo futurebuilder tiver dados
                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[           //Mostra uma linha com o poster do filme, o título e os gêneros do mesmo
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            width: 200.0,  
                            height: 295.0,
                            color: Colors.green,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(4),
                            child: new Image.network(snapshot.data.posterUrl.toString()),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 250,
                          child: Column(
                            children: <Widget>[
                                Container(
                                  width: 250.0,
                                  height: 75.0,
                                  child: Text(snapshot.data.title,
                                    style: TextStyle(fontSize: 30),),
                                    alignment: Alignment.centerLeft,
                                ),
                              Positioned(
                                top:0,
                                left:1,
                                child: Container(
                                  width: 250.0,
                                  height: 40.0,
                                  child: Text('Genres:\n' + snapshot.data.genres.join(', '),
                                        style: TextStyle(fontSize: 15),),
                                        alignment: Alignment.centerLeft,
                                ),
                              ),
                            ]
                          ),
                        ),
                      ],  
                    ),
                    Container(                  //Outros detalhes abaixo do poster, título e gêneros
                      child: Text('\n\nSynopsis:\n' + snapshot.data.overview.toString() +
                                  '\n\nStatus:\n' + snapshot.data.status +
                                  '\n\nRelease date:\n' + snapshot.data!.releaseDate.month.toString() +
                                  '/' + snapshot.data!.releaseDate.day.toString() +
                                  '/' + snapshot.data!.releaseDate.year.toString() +
                                  '\n\nRuntime:\n' + snapshot.data.runtime.toString() + ' minutes' +
                                  '\n\nAverage: ' + snapshot.data.voteAverage.toString() +
                                  '\n\nVotes: ' + snapshot.data.voteCount.toString() +
                                  '\n\nBudget:\nUS\$ ' + snapshot.data.budget.toString() + ',00'
                                  '\n\nPopularity:\n' + snapshot.data.popularity.toString(),
                                  ),
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(10),
                    ),
                  ],
                );
              } else if (snapshot.hasError){                        //Caso os snapshots não tiverem dados, vai para mensagem de erro
                return Container(
                  child: Center(
                    child: Text('Falha ao encontrar dados!')),
                    );
              } else {                                             //Caso o futurebuilder não der certo, sem mensagem de erro, apenas
                return Container(                                  //sinaliza busca
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}