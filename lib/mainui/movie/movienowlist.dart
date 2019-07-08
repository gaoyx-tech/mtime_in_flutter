import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mtime_in_flutter/mainui/detail/moviedetail.dart';
import 'dart:convert';
import 'movielistbean.dart';

//now movie list
class MovieNowListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }
}

//
class MovieListState extends State<MovieNowListWidget> {
  //
  List<MovieNowItem> _listData;
  int _nCount = 0;

  @override
  void initState() {
    super.initState();
    _requestNet();
  }

  //net request data
  void _requestNet() async {
    Response response = await new Dio().get(
        "https://ticket-api-m.mtime.cn/showing/movies.api",
        queryParameters: {"locationId": "290"});
    final jsonResponse = json.decode(response.toString());
    MovieNow nowAll = MovieNow.fromJson(jsonResponse);
    //
    if (mounted) {
      setState(() {
        _nCount = nowAll.data.ms.length;
        _listData = nowAll.data.ms;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    if (_listData == null || _listData.isEmpty) {
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
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic))
        ],
      ));
    }

    return ListView.separated(
      //构造分割线
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      }, //构造每一个item
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetailWidget(
                        sMovieId: _listData[index].movieId.toString()),
                    maintainState: false));
          },
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            height: 160,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //poster
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      _listData[index].img,
                      width: 110,
                      height: 148,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    )),
                //
                SizedBox(width: 12), //avoid overflow
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _listData[index].tCn,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      //
                      Text(_listData[index].actors,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      //
                      Text("${_listData[index].wantedCount} 人想看",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      //
                      Text("评分：${_listData[index].r}",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      //
                      Text(_listData[index].commonSpecial,
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700))
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      },
      itemCount: _nCount,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
