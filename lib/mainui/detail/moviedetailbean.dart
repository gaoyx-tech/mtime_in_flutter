class BoxOffice {
  final String totalBoxDes;
  final String totalBoxUnit;

  BoxOffice({this.totalBoxDes, this.totalBoxUnit});

  factory BoxOffice.fromJson(Map<String, dynamic> parseJson) {
    return BoxOffice(
        totalBoxDes: parseJson["totalBoxDes"],
        totalBoxUnit: parseJson["totalBoxUnit"]);
  }
}

//
class ActorItem {
  final String img;
  final String name;
  final String nameEn;

  ActorItem({this.img, this.nameEn, this.name});

  factory ActorItem.fromJson(Map<String, dynamic> parseJson) {
    return ActorItem(
        img: parseJson["img"],
        nameEn: parseJson["nameEn"],
        name: parseJson["name"]);
  }
}

//
class StageImgItem {
  final String imgUrl;

  StageImgItem({this.imgUrl});

  factory StageImgItem.fromJson(Map<String, dynamic> parseJson) {
    return StageImgItem(imgUrl: parseJson["imgUrl"]);
  }
}

//
class VideoInfo {
  final String hightUrl;
  final String img;
  final int videoId;

  VideoInfo({this.img, this.hightUrl, this.videoId});

  factory VideoInfo.fromJson(Map<String, dynamic> parseJson) {
    return VideoInfo(
        img: parseJson["img"],
        hightUrl: parseJson["hightUrl"],
        videoId: parseJson["videoId"]);
  }
}

//
class DirectorInfo {
  final String name;
  final String nameEn;

  DirectorInfo({this.name, this.nameEn});

  factory DirectorInfo.fromJson(Map<String, dynamic> parseJson) {
    return DirectorInfo(name: parseJson["name"], nameEn: parseJson["nameEn"]);
  }
}

//
class Basic {
  final List<ActorItem> actors;
  final DirectorInfo director;
  final String commentSpecial;
  final String img;
  final String mins;
  final String name;
  final String nameEn;
  final overallRating;
  final List<StageImgItem> stageImg;
  final String story;
  final List<String> type;
  final VideoInfo video;

  Basic(
      {this.commentSpecial,
      this.img,
      this.mins,
      this.name,
      this.nameEn,
      this.overallRating,
      this.story,
      this.actors,
      this.director,
      this.stageImg,
      this.type,
      this.video});

  factory Basic.fromJson(Map<String, dynamic> parseJson) {
    //actor list
    List<dynamic> actorsOriginal = parseJson["actors"];
    List<ActorItem> actors =
        actorsOriginal.map((item) => ActorItem.fromJson(item)).toList();
    //director
    DirectorInfo inf = DirectorInfo.fromJson(parseJson["director"]);
    //type
    List<dynamic> typesOriginal = parseJson["type"];
    List<String> types = typesOriginal.map((item) => item.toString()).toList();
    //video
    VideoInfo info = VideoInfo.fromJson(parseJson["video"]);
    //stageimg
    List<dynamic> stagesImgOr = parseJson["stageImg"]["list"];
    List<StageImgItem> stageImgs =
        stagesImgOr.map((item) => StageImgItem.fromJson(item)).toList();
//
    return Basic(
        commentSpecial: parseJson["commentSpecial"],
        img: parseJson["img"],
        mins: parseJson["mins"],
        nameEn: parseJson["nameEn"],
        name: parseJson["name"],
        overallRating: parseJson["overallRating"],
        story: parseJson["story"],
        actors: actors,
        director: inf,
        stageImg: stageImgs,
        type: types,
        video: info);
  }
}

//--------------------------------------------------------------------------------------------------------------------------------------------

class CommentItem {
  final String content;
  final String locationName;
  final String nickname;
  final rating;
  final commentDate;
  final String headImg;
  final String title;

  CommentItem(
      {this.commentDate,
      this.content,
      this.locationName,
      this.nickname,
      this.headImg,
      this.title,
      this.rating});

  factory CommentItem.fromJson(Map<String, dynamic> parseJson) {
    var titleVal = "";
    if (parseJson.containsKey("title")) titleVal = parseJson["title"];
    //
    return CommentItem(
        commentDate: parseJson["commentDate"],
        content: parseJson["content"],
        locationName: parseJson["locationName"],
        title: titleVal,
        nickname: parseJson["nickname"],
        headImg: parseJson["headImg"],
        rating: parseJson["rating"]);
  }
}

//
class CommentData {
  final List<CommentItem> mini;
  final List<CommentItem> plus;

  CommentData({this.mini, this.plus});

  //
  factory CommentData.fromJson(List<dynamic> listMini, List<dynamic> listPlus) {
    List<CommentItem> lstMini =
        listMini.map((item) => CommentItem.fromJson(item)).toList();
    List<CommentItem> lstPlus =
        listPlus.map((item) => CommentItem.fromJson(item)).toList();
    return CommentData(mini: lstMini, plus: lstPlus);
  }
}
