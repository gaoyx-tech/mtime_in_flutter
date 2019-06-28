import 'package:flutter/material.dart';

class PreviewList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PreviewListState();
  }
}

class PreviewListState extends State<PreviewList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _createPreviewItem();
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 2, color: Colors.grey);
        },
        itemCount: 30);
  }

  Widget _createPreviewItem() {
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
                  Image.network(
                      'http://img5.mtime.cn/mg/2019/06/17/102114.71512975.jpg',
                      width: double.infinity,
                      height: 245,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover),
                  //前景昏暗
                  Container(
                      color: Colors.black38,
                      height: 245,
                      width: double.infinity),
                  Positioned(
                      right: 15,
                      bottom: 10,
                      child: Text('共播放100次',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 13))),
                ],
              )),
          //文字部分
          SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('解放了 首支预告',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87))),
          SizedBox(height: 5),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('钟汉良战争大片《解放了》预告',
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                      fontWeight: FontWeight.w300))),
        ],
      ),
    );
  }
}
