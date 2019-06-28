import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mtime_in_flutter/mainui/mainpage.dart';
import 'package:mtime_in_flutter/mainui/detail/moviedetail.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'splashbean.dart';

void main() => runApp(SplashWidget());

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashPage> {
  List<RcmdItem> _listResult;
  RcmdItem _dataResult;

  @override
  void initState() {
    super.initState();
    _getNetRcmdMovie();
  }

  //
  void _getNetRcmdMovie() async {
    Response response = await Dio()
        .get('https://content-api-m.mtime.cn/dailyRcmdMoviesByMonth.api');
    final jsonStr = json.decode(response.toString());
    HistoryData data = HistoryData.fromJson(jsonStr["data"]["historyMovie"]);
    setState(() {
      if (data.movies[0].list.length > 10)
        _listResult = data.movies[0].list;
      else
        _listResult = data.movies[1].list;
      //random select
      _dataResult = _listResult[Random().nextInt(_listResult.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_dataResult == null) return Container(color: Colors.white);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //海报页
          Positioned(
            bottom: 150,
            child: Image.network(
              _dataResult.poster,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          //点击进入主页
          Positioned(
            right: 20,
            top: 30,
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.black45,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "点击进入主页",
                style: TextStyle(fontSize: 12),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(width: 0.5, color: Colors.white)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MainPageBottomTabWidget(), //点击进入主页
                        maintainState: false));
              },
            ),
          ),
          //点击进入海报页
          Positioned(
              right: 20,
              top: 75,
              child: FlatButton(
                textColor: Colors.white,
                padding: const EdgeInsets.only(left: 10, right: 10),
                color: Colors.black45,
                child: Text(
                  '点击进入海报页',
                  style: TextStyle(fontSize: 12),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(width: 0.5, color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailWidget(sMovieId: _dataResult.movieId),
                          //点击进入海报的详情页
                          maintainState: false));
                },
              )),
          //台词和电影名称
          Positioned(
              bottom: 50, //此子widget底边，距离stack父布局底边的距离
              left: 10,
              right: 10,
              //linearlayout vertical
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "“${_dataResult.rcmdQuote}”",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  //分割
                  SizedBox(
                    height: 20,
                    width: double.infinity,
                  ),
                  Text(
                    _dataResult.desc,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
