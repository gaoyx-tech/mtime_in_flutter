//movie now 相关
class MovieNowItem {
  final String tCn;
  final String img;
  final String commonSpecial;
  final int movieId;
  final r; //有double，有int，就不能写数据类型，切记
  final String actors;
  final int wantedCount;

  MovieNowItem(
      {this.tCn,
      this.actors,
      this.commonSpecial,
      this.img,
      this.movieId,
      this.wantedCount,
      this.r});

  //
  factory MovieNowItem.fromJson(Map<String, dynamic> parsedJson) {
    return MovieNowItem(
        tCn: parsedJson["tCn"],
        actors: parsedJson["actors"],
        commonSpecial: parsedJson["commonSpecial"],
        img: parsedJson["img"],
        movieId: parsedJson["movieId"],
        wantedCount: parsedJson["wantedCount"],
        r: parsedJson["r"]);
  }
}

//
class MovieNowData {
  final List<MovieNowItem> ms;

  MovieNowData({this.ms});

  factory MovieNowData.fromJson(List<dynamic> list) {
    //important
    List<MovieNowItem> slist =
        list.map((i) => MovieNowItem.fromJson(i)).toList();
    return MovieNowData(ms: slist);
  }
}

//
class MovieNow {
  final MovieNowData data;

  MovieNow({this.data});

  factory MovieNow.fromJson(Map<String, dynamic> parsedJson) {
    final jsonData = parsedJson["data"];
    MovieNowData data2 = MovieNowData.fromJson(jsonData["ms"]);
    return MovieNow(data: data2);
  }
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//movie coming 相关
class MovieComingItem {
  final String title;
  final String releaseDate;
  final int movieId;
  final String image;
  final int wantedCount;

  MovieComingItem(
      {this.title,
      this.releaseDate,
      this.wantedCount,
      this.movieId,
      this.image});

  factory MovieComingItem.fromJson(Map<String, dynamic> parseJson) {
    return MovieComingItem(
        title: parseJson["title"],
        releaseDate: parseJson["releaseDate"],
        wantedCount: parseJson["wantedCount"],
        movieId: parseJson["movieId"],
        image: parseJson["image"]);
  }
}

//
class ComingRecommendsItem {
  final String recommendTitle;
  final List<MovieComingItem> movies;

  ComingRecommendsItem({this.movies, this.recommendTitle});

  factory ComingRecommendsItem.fromJson(String title, List<dynamic> list) {
    List<MovieComingItem> list2 =
        list.map((i) => MovieComingItem.fromJson(i)).toList();
    return ComingRecommendsItem(movies: list2, recommendTitle: title);
  }
}

//
class MovieComingData {
  final List<MovieComingItem> moviecomings;
  final List<ComingRecommendsItem> recommends;

  MovieComingData({this.moviecomings, this.recommends});

  factory MovieComingData.fromJson(List<dynamic> list1, List<dynamic> list2) {
    List<MovieComingItem> lst1 = list1
        .map((item) => MovieComingItem.fromJson(item))
        .toList(); //根据第一个class知道，item是一个map
    //
    List<ComingRecommendsItem> lst2 = List();
    list2.forEach((elem) => {
          lst2.add(ComingRecommendsItem.fromJson(
              elem["recommendTitle"].toString(), elem["movies"]))
        });
    return MovieComingData(moviecomings: lst1, recommends: lst2);
  }
}
