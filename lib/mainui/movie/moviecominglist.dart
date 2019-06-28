import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mtime_in_flutter/mainui/detail/moviedetail.dart';
import 'dart:convert';
import 'movielistbean.dart';

class MovieComingListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MovieComingListState();
  }
}

class MovieComingListState extends State<MovieComingListWidget>{
  //member
  List<MovieComingItem> _listComing;
  List<ComingRecommendsItem> _listRecommends;
  int nComingCount = 0;
  int nRecommendCount = 0;
  int nTotalCount = 0;

  @override
  void initState() {
    super.initState();
    _getNetComingData();
  }

  void _getNetComingData() async {
    Response res = await new Dio().get(
        "https://ticket-api-m.mtime.cn/movie/mobilemoviecoming.api",
        queryParameters: {"locationId": "290"});
    final jsonData = json.decode(res.toString());
    final realData = jsonData["data"];
    MovieComingData data = MovieComingData.fromJson(
        realData["moviecomings"], realData["recommends"]);
    //
    if (mounted) {
      setState(() {
        _listComing = data.moviecomings;
        _listRecommends = data.recommends;
        nComingCount = _listComing.length;
        nRecommendCount = _listRecommends.length;
        nTotalCount = nComingCount + nRecommendCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (nTotalCount != 0) {
      return ListView.separated(
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          if (index < nRecommendCount)
            return buildRecommendItem(index);
          else
            return buildComingItem(context, index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Colors.black45);
        },
        itemCount: nTotalCount,
      );
    } else
      return Container(
        width: 0,
        height: 0,
      );
  }

  Widget buildComingItem(BuildContext context, int index) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  maintainState: false,
                  builder: (BuildContext context) {
                    return MovieDetailWidget(
                        sMovieId: _listComing[index - nRecommendCount]
                            .movieId
                            .toString());
                  }));
        },
        child: Container(
          width: double.infinity,
          height: 160,
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.network(
                _listComing[index - nRecommendCount].image,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                width: 110,
                height: 140,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _listComing[index - nRecommendCount].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87),
                  ),
                  SizedBox(height: 12),
                  //
                  Text(
                    "${_listComing[index - nRecommendCount].wantedCount} 人想看",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 12),
                  //
                  Text(
                    "${_listComing[index - nRecommendCount].releaseDate} 上映",
                    style: TextStyle(
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildRecommendItem(int nIndex) {
    return Container(
        width: double.infinity,
        height: 220,
        padding: const EdgeInsets.only(top: 2, left: 2),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _listRecommends[nIndex].recommendTitle,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              //
              SizedBox(height: 10),
              //横向listview
              Container(
                  height: 180,
                  width: double.infinity,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                  _listRecommends[nIndex].movies[index].image,
                                  height: 150,
                                  width: 110,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover),
                              //
                              SizedBox(height: 5),
                              //
                              Container(
                                width: 100,
                                child: Text(
                                  _listRecommends[nIndex].movies[index].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                alignment: Alignment.center,
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    maintainState: false,
                                    builder: (BuildContext context) {
                                      return MovieDetailWidget(
                                          sMovieId: _listRecommends[nIndex]
                                              .movies[index]
                                              .movieId
                                              .toString());
                                    }));
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(width: 5);
                      },
                      itemCount: _listRecommends[nIndex].movies.length))
            ]));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
