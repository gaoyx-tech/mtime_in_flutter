import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mtime_in_flutter/mainui/detail/moviedetail.dart';
import 'dart:convert';
import 'package:mtime_in_flutter/mainui/rank/ranklistbean.dart';

class RankNationList extends StatefulWidget {
  final String sRequestNumber;

  RankNationList({Key key, this.sRequestNumber});

  @override
  State<StatefulWidget> createState() {
    return RankNationState();
  }
}

class RankNationState extends State<RankNationList> {
  List<RankItem> _listData = new List<RankItem>();

  //
  Widget _createRankItem(int index) {
    return Container(
        height: 170,
        width: double.infinity,
        color: Colors.white30,
        child: Card(
            elevation: 8.0,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.network(_listData[index].posterUrl,
                      height: 150,
                      width: 110,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high),
                  //
                  SizedBox(width: 15),
                  //
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        //
                        Text(
                            _listData[index].name +
                                "(${_listData[index].nameEn})",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2),
                        SizedBox(height: 20),
                        Text(
                            _listData[index]
                                .weekBoxOffice
                                .replaceAll("\n", " "),
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 5),
                        Text(
                            _listData[index]
                                .totalBoxOffice
                                .replaceAll("\n", ""),
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ]))
                ])));
  }

  void _getRequestNetData() async {
    Response response = await new Dio().get(
        'https://api-m.mtime.cn/TopList/TopListDetailsByRecommend.api',
        queryParameters: {
          "locationId": "290",
          "pageSubAreaID": widget.sRequestNumber,
          "pageIndex": "1"
        });
    final jsonResponse = json.decode(response.toString());
    RankMovie movies = RankMovie.fromJson(jsonResponse["movies"]);
    if (mounted) {
      setState(() {
        _listData = movies.movies;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getRequestNetData();
  }

  @override
  Widget build(BuildContext context) {
    if (_listData.isEmpty) {
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
            Text('数据加载中....',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic))
          ]));
    }
    return ListView.builder(
        itemBuilder: (BuildContext context1, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context1,
                    MaterialPageRoute(
                        maintainState: false,
                        builder: (BuildContext context) {
                          return MovieDetailWidget(
                              sMovieId: _listData[index].id.toString());
                        }));
              },
              child: _createRankItem(index));
        },
        itemCount: _listData.length);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
