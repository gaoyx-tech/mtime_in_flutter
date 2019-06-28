class RankItem {
  var id;
  final String name;
  final String nameEn;
  final rankNum;
  final String posterUrl;
  final String weekBoxOffice;
  final String totalBoxOffice;

  RankItem(
      {this.id,
      this.name,
      this.nameEn,
      this.rankNum,
      this.posterUrl,
      this.weekBoxOffice,
      this.totalBoxOffice});

  //
  factory RankItem.fromJson(Map<String, dynamic> parsedJson) {
    return RankItem(
        id: parsedJson["id"],
        name: parsedJson["name"],
        nameEn: parsedJson["nameEn"],
        rankNum: parsedJson["rankNum"],
        posterUrl: parsedJson["posterUrl"],
        weekBoxOffice: parsedJson["weekBoxOffice"],
        totalBoxOffice: parsedJson["totalBoxOffice"]);
  }
}

//
class RankMovie {
  final List<RankItem> movies;

  RankMovie({this.movies});

  //
  factory RankMovie.fromJson(List<dynamic> list) {
    List<RankItem> items = list.map((item) => RankItem.fromJson(item)).toList();
    return RankMovie(movies: items);
  }
}
