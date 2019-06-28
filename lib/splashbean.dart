class RcmdItem {
  final String desc;
  final String movieId;
  final String poster;
  final String rcmdQuote;

  RcmdItem({this.desc, this.movieId, this.poster, this.rcmdQuote});

  factory RcmdItem.fromJson(Map<String, dynamic> parseJson) {
    return RcmdItem(
        desc: parseJson["desc"],
        movieId: parseJson["movieId"],
        poster: parseJson["poster"],
        rcmdQuote: parseJson["rcmdQuote"]);
  }
}

//
class HistoryMovieItem {
  List<RcmdItem> list;

  HistoryMovieItem({this.list});

  factory HistoryMovieItem.fromJson(List<dynamic> listData) {
    List<RcmdItem> list1 =
        listData.map((item) => RcmdItem.fromJson(item)).toList();
    return HistoryMovieItem(list: list1);
  }
}

//
class HistoryData {
  List<HistoryMovieItem> movies;

  HistoryData({this.movies});

  //
  factory HistoryData.fromJson(List<dynamic> datas) {
    List<HistoryMovieItem> listTmp = new List();
    for (var value in datas) {
      listTmp.add(HistoryMovieItem.fromJson(value["rcmdList"]));
    }
    return HistoryData(movies: listTmp);
  }
}
