import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'moviedetailbean.dart';

// ignore: must_be_immutable
class MovieDetailVideoPage extends StatelessWidget {
  final movieId;
  int pageIndex = 1;

  MovieDetailVideoPage({this.movieId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        builder: (context) => AllVideoBloc(),
        child: Scaffold(
            appBar: AppBar(
                title: Text('影片所有视频',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500)),
                centerTitle: true,
                backgroundColor: Colors.black87),
            body: VideoListView(movieId: movieId)));
  }
}

// ignore: must_be_immutable
class VideoListView extends StatelessWidget {
  AllVideoBloc bloc;
  int pageIndex = 1;
  final movieId;
  final ScrollController _scrollController = new ScrollController();

  VideoListView({this.movieId}) {
    _scrollController.addListener(() {
      //判断当前滑动位置是不是到达底部，触发加载更多回调
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        bloc.getNetData(movieId, ++pageIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (bloc == null) {
      bloc = Provider.of<AllVideoBloc>(context);
      bloc.getNetData(movieId, pageIndex);
    }
    if (bloc.getData().videoList.length == 0)
      return Center(
          child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
              strokeWidth: 5.0));
    else {
      return ListView.builder(
	      controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            //
            if (index < bloc.getData().videoList.length)
              return _createVideoItem(context, index);
            else
              return Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.white,
                  child: Row(children: <Widget>[
                    CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.deepOrangeAccent),
                        strokeWidth: 3),
                    SizedBox(width: 10),
                    Text("更多加载中....",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500))
                  ], mainAxisAlignment: MainAxisAlignment.center));
          },
          itemCount: bloc.getData().videoList.length + 1);
    }
  }

  Widget _createVideoItem(BuildContext context, int index) {
    return Container(
      width: double.infinity,
      height: 230,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(bloc.getData().videoList[index].image,
              width: double.infinity,
              height: 230,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high),
          //black
          Container(width: double.infinity, height: 230, color: Colors.black45),
          //
          Positioned(
              top: 15,
              left: 10,
              child: Text(bloc.getData().videoList[index].title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400))),
          //
          Positioned(
              top: 15,
              right: 10,
              child: Text('播放${bloc.getData().videoList[index].playCount}次',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400))),
          //
          Positioned(
              bottom: 15,
              right: 10,
              child: Text('时长${bloc.getData().videoList[index].length}秒',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                      fontSize: 13))),
          Center(
              child: IconButton(
                  color: Colors.white,
                  iconSize: 42,
                  icon: Icon(Icons.play_circle_outline),
                  onPressed: () {}))
        ],
      ),
    );
  }
}
