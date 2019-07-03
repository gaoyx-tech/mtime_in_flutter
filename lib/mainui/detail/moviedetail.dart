import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:mtime_in_flutter/mainui/detail/moviedetailbean.dart';
import 'package:mtime_in_flutter/mainui/detail/moviedetailshortview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieDetailWidget extends StatefulWidget {
  //
  final String sMovieId;

  MovieDetailWidget({Key key, this.sMovieId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MovieDetailState();
  }
}

class MovieDetailState extends State<MovieDetailWidget>
    with AutomaticKeepAliveClientMixin {
  //
  Basic _allInfo;
  CommentData _commentData;

  //about love icon
  String mLoveMovies = "";
  bool isLoved;

  @override
  void initState() {
    super.initState();
    _getNetMovieDetail();
    _getMovieIsLoved();
  }

  //is loved movie?
  void _getMovieIsLoved() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    mLoveMovies = pref.getString("lovemovies") ?? "";
    //
    setState(() {
      if (mLoveMovies.contains(widget.sMovieId) == false)
        isLoved = false;
      else
        isLoved = true;
    });
  }

  //set movie love
  void _setMovieIsLoved() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (mLoveMovies.contains(widget.sMovieId)) {
      mLoveMovies = mLoveMovies.replaceAll("${widget.sMovieId},", "");
      pref.setString("lovemovies", mLoveMovies);
    } else {
      mLoveMovies += "${widget.sMovieId},";
      pref.setString("lovemovies", mLoveMovies);
    }
  }

  //get movie detail info
  Future<void> _getNetMovieDetail() async {
    var dio = Dio();
    //合并多个请求，同时返回
    List<Response> responses = await Future.wait([
      dio.get("https://ticket-api-m.mtime.cn/movie/detail.api",
          queryParameters: {"locationId": "290", "movieId": widget.sMovieId}),
      dio.get("https://ticket-api-m.mtime.cn/movie/hotComment.api",
          queryParameters: {"movieId": widget.sMovieId})
    ]);
    //基本信息
    final jsonStr0 = json.decode(responses[0].toString());
    Basic allInf = Basic.fromJson(jsonStr0["data"]["basic"]);
    //评论信息
    final jsonStr1 = json.decode(responses[1].toString());
    CommentData dataComm = CommentData.fromJson(
        jsonStr1["data"]["mini"]["list"], jsonStr1["data"]["plus"]["list"]);
    setState(() {
      _allInfo = allInf;
      _commentData = dataComm;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_allInfo == null || _commentData == null)
      return Scaffold(
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
            CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
            Text('数据加载中...',
                style: TextStyle(
                    color: Colors.black87,
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                    fontWeight: FontWeight.w500)),
          ])));
    //
    return Scaffold(
        body: RefreshIndicator(
            color: Colors.black,
            displacement: 70,
            backgroundColor: Colors.white,
            onRefresh: () {
              _getNetMovieDetail();
            },
            child: ListView(
              padding: EdgeInsets.only(top: 0), //Listview无法在页面中置顶的解决方案
              scrollDirection: Axis.vertical,
              children: <Widget>[
                //顶部播放海报示意
                buildHeadPosterPlay(context),
                SizedBox(height: 10),
                setPadding(buildHeadBaseInfo()), //上部基本信息
                SizedBox(height: 10),
                setPadding(buildIntroduce()), //介绍
                SizedBox(height: 10),
                setPadding(buildActorsListView()), //演员列表
                SizedBox(height: 10),
                setPadding(buildPosterImages()), //四张海报
                SizedBox(height: 10),
                setPadding(buildShortReview()), //短评
                SizedBox(height: 5),
                setPadding(GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              maintainState: false,
                              builder: (context) => MovieDetailShortView(
                                  movieId: widget.sMovieId)));
                    },
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text('点击查看更多短评',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500))))),
                SizedBox(height: 10),
                setPadding(buildLongReview()), //长评
                SizedBox(height: 5),
                setPadding(GestureDetector(
                    onTap: () {},
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text('点击查看更多长评',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic)))))
              ],
            )));
  }

  //设置内边距
  Widget setPadding(final Widget widget) {
    return Padding(
      child: widget,
      padding: const EdgeInsets.only(left: 5, right: 5),
    );
  }

  //long review
  Widget buildLongReview() {
    if (_commentData.plus.length == 0) return Container(color: Colors.white);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '长评：',
          style: TextStyle(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        //
        SizedBox(height: 10),
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                //只需要设置backgroundimage
                _commentData.plus[0].headImg,
              ),
              radius: 18.0, //控制大小的
            ),
            SizedBox(width: 10),
            Text(
              _commentData.plus[0].nickname,
              style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54),
            ),
          ],
        ),
        SizedBox(height: 6),
        //title
        Text(
          _commentData.plus[0].title,
          style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              color: Colors.black87),
        ),
        SizedBox(height: 6),
        //content
        Text(
          _commentData.plus[0].content,
          maxLines: 30,
          style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300,
              color: Colors.black54),
        ),
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _commentData.plus[0].commentDate.toString(),
              style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
            Text(
              '评分：${_commentData.plus[0].rating}',
              style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }

  //short review
  Widget buildShortReview() {
    if (_commentData.mini.length == 0) return Container(color: Colors.white);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('短评：',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
        ListView.builder(
          //如果不加入paddingtop为0，则不会顶到头部
          padding: const EdgeInsets.only(top: 0),
          //禁止滚动，只是总listview的一部分
          physics: const NeverScrollableScrollPhysics(),
          //切记，切记，listview套入到listview，当都是竖向时，必须指定shrinkWrap为true属性
          shrinkWrap: true,
          itemCount: _commentData.mini.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //第一行
                  Row(
                    children: <Widget>[
                      Image.network(
                        _commentData.mini[index].headImg,
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 5),
                      Text(
                        _commentData.mini[index].nickname,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),

                  //第二行
                  Text(
                    _commentData.mini[index].content,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  //第三行
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _commentData.mini[index].commentDate.toString(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                      Text(
                        '评分：${_commentData.mini[index].rating}',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                  //分割线
                  Divider(height: 2, color: Colors.grey)
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  //4 posters
  Widget buildPosterImages() {
    if (_allInfo.stageImg.length == 0) return Container(width: 0, height: 0);
    //不足4个，补充空字符串，不管差几个，都补充三个
    if (_allInfo.stageImg.length < 4) {
      for (var i = 0; i < 3; ++i) {
        _allInfo.stageImg.add(StageImgItem(imgUrl: ""));
      }
    }
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '电影海报：',
          style: TextStyle(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        //
        SizedBox(height: 10),
        Container(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Image.network(
                  _allInfo.stageImg[0].imgUrl,
                  fit: BoxFit.cover,
                  height: 150,
                ),
              ),
              SizedBox(width: 3),
              Expanded(
                child: Image.network(
                  _allInfo.stageImg[1].imgUrl,
                  fit: BoxFit.cover,
                  height: 150,
                ),
              ),
            ],
          ),
        ),
        //
        SizedBox(height: 3),
        //
        Container(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Image.network(
                  _allInfo.stageImg[2].imgUrl,
                  fit: BoxFit.cover,
                  height: 150,
                ),
              ),
              SizedBox(width: 3),
              Expanded(
                child: Image.network(
                  _allInfo.stageImg[3].imgUrl,
                  fit: BoxFit.cover,
                  height: 150,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  //构建一个头部播放海报页
  Widget buildHeadPosterPlay(BuildContext context) {
    Widget iconLove;
    if (isLoved == false) {
      iconLove = IconButton(
          icon: Icon(Icons.favorite_border),
          color: Colors.white,
          onPressed: () {
            _setMovieIsLoved();
            setState(() {
              isLoved = true;
            });
          });
    } else {
      iconLove = IconButton(
          icon: Icon(Icons.favorite),
          color: Colors.red,
          onPressed: () {
            _setMovieIsLoved();
            setState(() {
              isLoved = false;
            });
          });
    }
    //
    return Container(
        height: 240,
        child: Stack(
          //如果是nonposition，则下面属性生效
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(_allInfo.stageImg[0].imgUrl, fit: BoxFit.cover),
            Container(
                width: double.infinity, height: 240, color: Colors.black45),
            Positioned(
              left: 25,
              top: 45,
              child: GestureDetector(
                child: Text(
                  '< 返回',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            //
            Positioned(right: 20, top: 45, child: iconLove)
          ],
        ));
  }

  //头部基本信息
  Widget buildHeadBaseInfo() {
    return Container(
      height: 160,
      child: Row(
        children: <Widget>[
          Image.network(
            _allInfo.img,
            fit: BoxFit.cover,
            width: 120,
          ),
          //
          SizedBox(width: 8),
          //base info            //这个expand是防止横向出格子
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //这个expand是防止竖向出格子报错且平分空间
                Expanded(
                  child: Text(
                    _allInfo.name + "(${_allInfo.nameEn})",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  flex: 1,
                ), //
                Expanded(
                  child: Text(
                    _allInfo.director.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  flex: 1,
                ), //
                Expanded(
                  child: Text(
                    "时长：${_allInfo.mins}",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  flex: 1,
                ), //
                Expanded(
                  child: Text(
                    _allInfo.type.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  flex: 1,
                ), //
                Expanded(
                  child: Text(
                    '评分：${_allInfo.overallRating}',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  flex: 1,
                ), //
                Expanded(
                  child: Text(
                    '\"${_allInfo.commentSpecial}\"',
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  flex: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //对于Column放置到垂直布局中ListView则需要移除内部的Expanded和Flex控件
  Widget buildIntroduce() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '电影介绍：',
          style: TextStyle(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 5),
        Text(_allInfo.story,
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w300,
                fontSize: 14,
                letterSpacing: 0.3),
            maxLines: 10000),
      ],
    );
  }

  Widget buildActorsListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '演职人员：',
          style: TextStyle(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 5),
        //
        Container(
          height: 200,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                //item 样式
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(_allInfo.actors[index].img,
                        height: 160, width: 120, fit: BoxFit.cover),
                    //
                    SizedBox(height: 5),
                    //
                    Container(
                        width: 120,
                        alignment: Alignment.center,
                        child: Text(
                            _allInfo.actors[index].name ??
                                _allInfo.actors[index].nameEn,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis))
                  ],
                ),
              );
            },
            itemCount: _allInfo.actors.length,
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
