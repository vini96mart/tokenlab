import 'dart:convert';

//Construtor da classe da lista de filmes, puxados do primeiro API

List<FilmeModel> FilmeModelFromJson(String str) => List<FilmeModel>.from(json.decode(str).map((x) => FilmeModel.fromJson(x)));

String FilmeModelToJson(List<FilmeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilmeModel {
    FilmeModel({
        this.id,
        this.voteAverage,
        this.title,
        this.posterUrl,
        this.genres,
        this.releaseDate,
    });

    int? id;
    double? voteAverage;
    String? title;
    String? posterUrl;
    List<String>? genres;
    DateTime? releaseDate;

    factory FilmeModel.fromJson(Map<String, dynamic> json) => FilmeModel(
        id: json["id"],
        voteAverage: json["vote_average"].toDouble(),
        title: json["title"],
        posterUrl: json["poster_url"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        releaseDate: DateTime.parse(json["release_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "vote_average": voteAverage,
        "title": title,
        "poster_url": posterUrl,
        "genres": List<dynamic>.from(genres!.map((x) => x)),
        "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    };
}
