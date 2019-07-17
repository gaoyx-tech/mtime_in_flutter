import 'package:flutter/material.dart';

class Me extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black87,
            title: Text('我的与筛选',
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    fontWeight: FontWeight.w600))),
        body: createListBody());
  }

  Widget createListBody() {
    return ListView(padding: const EdgeInsets.only(top: 0), children: <Widget>[
      //
      Container(
          width: double.infinity,
          height: 150,
          child: PageView.builder(
              itemBuilder: (BuildContext context, int index) {
                return FadeInImage.assetNetwork(
                    placeholder: 'images/test1.png',
                    alignment: Alignment.centerRight,
                    image:
                        "http://img5.mtime.cn/mt/2019/06/28/141445.67206086_1280X720X2.jpg",
                    fit: BoxFit.cover);
              },
              itemCount: 8))
    ]);
  }
}
