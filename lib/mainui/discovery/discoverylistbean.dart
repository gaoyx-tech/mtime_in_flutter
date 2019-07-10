import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

//cinema
class CinemaFeature {
  final int has3D;
  final int hasFeature4D;
  final int hasFeature4K;
  final int hasFeatureDolby;
  final int hasFeatureHuge;
  final int hasIMAX;
  final int hasLoveseat;
  final int hasPark;
  final int hasScreenX;
  final int hasServiceTicket;
  final int hasSphereX;
  final int hasVIP;
  final int hasWifi;

  //
  CinemaFeature(
      {this.has3D,
      this.hasFeature4D,
      this.hasFeature4K,
      this.hasFeatureDolby,
      this.hasFeatureHuge,
      this.hasIMAX,
      this.hasLoveseat,
      this.hasPark,
      this.hasScreenX,
      this.hasServiceTicket,
      this.hasSphereX,
      this.hasVIP,
      this.hasWifi});

  //
  factory CinemaFeature.fromJson(Map<String, dynamic> parseJson) {
    return CinemaFeature(
        has3D: parseJson["has3D"],
        hasFeature4D: parseJson["hasFeature4D"],
        hasFeature4K: parseJson["hasFeature4K"],
        hasFeatureDolby: parseJson["hasFeatureDolby"],
        hasFeatureHuge: parseJson["hasFeatureHuge"],
        hasIMAX: parseJson["hasIMAX"],
        hasLoveseat: parseJson["hasLoveSeat"],
        hasPark: parseJson["hasPark"],
        hasScreenX: parseJson["hasScreenX"],
        hasServiceTicket: parseJson["hasServiceTicket"],
        hasSphereX: parseJson["hasSphereX"],
        hasVIP: parseJson["hasVIP"],
        hasWifi: parseJson["hasWifi"]);
  }
}

//
class CinemaItem {
  final String address;
  final String cinameName;
  final ratingFinal;
  final CinemaFeature feature;
  final latitude;
  final longitude;

  //
  CinemaItem(
      {this.address,
      this.cinameName,
      this.ratingFinal,
      this.feature,
      this.latitude,
      this.longitude});

  //
  factory CinemaItem.fromJson(Map<String, dynamic> parseJson) {
    return CinemaItem(
        address: parseJson["address"],
        cinameName: parseJson["cinameName"],
        ratingFinal: parseJson["ratingFinal"],
        feature: CinemaFeature.fromJson(parseJson["feature"]),
        latitude: parseJson["latitude"],
        longitude: parseJson["longitude"]);
  }
}

//
class CinemaListData {
  final List<CinemaItem> cinemaList;

  CinemaListData({this.cinemaList});

  //
  factory CinemaListData.fromJson(List<dynamic> listData) {
    List<CinemaItem> lst =
        listData.map((item) => CinemaItem.fromJson(item)).toList();
    return CinemaListData(cinemaList: lst);
  }
}

//预告片------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class TrailerItem {
  final String coverImg;
  final String hightUrl;
  final String movieName;
  final String playCount;
  final videoLength;
  final String videoTitle;

  //
  TrailerItem(
      {this.coverImg,
      this.hightUrl,
      this.movieName,
      this.playCount,
      this.videoLength,
      this.videoTitle});

  //
  factory TrailerItem.fromJson(Map<String, dynamic> parseJson) {
    return TrailerItem(
        coverImg: parseJson["coverImg"],
        hightUrl: parseJson["hightUrl"],
        movieName: parseJson["movieName"],
        playCount: parseJson["playCount"],
        videoLength: parseJson["videoLength"],
        videoTitle: parseJson["videoTitle"]);
  }
}

class TrailerItemList {
  final List<TrailerItem> listData;

  TrailerItemList({this.listData});

  //
  factory TrailerItemList.fromJson(List<dynamic> lstData) {
    List<TrailerItem> list1 =
        lstData.map((item) => TrailerItem.fromJson(item)).toList();
    return TrailerItemList(listData: list1);
  }
}

//
class TrailerBloc extends ChangeNotifier {
  List<TrailerItem> listData = List();

  void getNetData() async {
    Response response = await Dio()
        .get("https://ticket-api-m.mtime.cn/discovery/trailerList.api");
    final jsonStr = json.decode(response.toString());
    TrailerItemList objData =
        TrailerItemList.fromJson(jsonStr["data"]["trailers"]);
    this.listData.addAll(objData.listData);
    notifyListeners();
  }

  //
  List<TrailerItem> getData() => this.listData;
}

//评论------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class CommentMovie {
  final String image;
  final String title;
  final String titleEn;
  final String year;
  final int id;

  CommentMovie({this.image, this.title, this.titleEn, this.year, this.id});

  factory CommentMovie.fromJson(Map<String, dynamic> parseJson) {
    return CommentMovie(
        image: parseJson["image"],
        title: parseJson["title"],
        year: parseJson["year"],
        id: parseJson["id"],
        titleEn: parseJson["titleEn"]);
  }
}

//
class CommentItem {
  final CommentMovie movie;
  final String nickname;
  final String summary;
  final String title;
  final String userImage;
  final rating;

  //
  CommentItem(
      {this.title,
      this.movie,
      this.nickname,
      this.rating,
      this.summary,
      this.userImage});

  //
  factory CommentItem.fromJson(Map<String, dynamic> parseJson) {
    return CommentItem(
        movie: CommentMovie.fromJson(parseJson["relatedObj"]),
        title: parseJson["title"],
        nickname: parseJson["nickname"],
        rating: parseJson["rating"],
        summary: parseJson["summary"],
        userImage: parseJson["userImage"]);
  }
}

class CommentAllData {
  final List<CommentItem> datas;

  CommentAllData({this.datas});

  factory CommentAllData.fromJson(List<dynamic> itemsParam) {
    List<CommentItem> items1 =
        itemsParam.map((itemData) => CommentItem.fromJson(itemData)).toList();
    return CommentAllData(datas: items1);
  }
}

//
class CommentBloc extends ChangeNotifier {
  //
  List<CommentItem> items = List();

  List<CommentItem> getData() => items;

  //
  void getNetData() async {
    Response response = await Dio()
        .get('https://api-m.mtime.cn/MobileMovie/Review.api?needTop=false');
    CommentAllData data = CommentAllData.fromJson(response.data);
    items.addAll(data.datas);
    notifyListeners();
  }
}
