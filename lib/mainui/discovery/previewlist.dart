import 'package:flutter/material.dart';
import 'package:mtime_in_flutter/mainui/discovery/discoverylistbean.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PreviewList extends StatelessWidget {
  //
  TrailerBloc bloc;

  @override
  Widget build(BuildContext context) {
    if (bloc == null) {
      bloc = Provider.of<TrailerBloc>(context);
      bloc.getNetData();
    }
    if (bloc.listData.length == 0) {
      return Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              strokeWidth: 1.5));
    }
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _createPreviewItem(index);
        },
        itemCount: bloc.listData.length);
  }

  Widget _createPreviewItem(int index) {
    return Container(
      width: double.infinity,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //poster图片部分
          Container(
              width: double.infinity,
              height: 245,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(bloc.listData[index].coverImg,
                      width: double.infinity,
                      height: 245,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover),
                  //前景昏暗
                  Container(
                      color: Colors.black45,
                      height: 245,
                      width: double.infinity),
                  Positioned(
                      right: 15,
                      bottom: 10,
                      child: Text('共播放${bloc.listData[index].playCount}次',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 13))),
                  GestureDetector(
                      onTap: () {},
                      child: Center(
                          child: IconButton(
                        iconSize: 37,
                        color: Colors.white,
                        icon: Icon(Icons.play_circle_outline),
                        onPressed: () {},
                      )))
                ],
              )),
          //文字部分
          SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(bloc.listData[index].videoTitle,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87))),
          SizedBox(height: 5),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(bloc.listData[index].movieName,
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                      fontWeight: FontWeight.w300))),
        ],
      ),
    );
  }
}
