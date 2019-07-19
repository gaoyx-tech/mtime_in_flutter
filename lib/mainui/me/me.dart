import 'package:flutter/material.dart';

class Me extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black87,
            title: Text('筛选',
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    fontWeight: FontWeight.w600))),
        body: createListBody());
  }

  Widget createListBody() {
    return ListView(children: <Widget>[
      //
      Container(
          width: double.infinity,
          height: 160,
          margin: const EdgeInsets.only(top: 10),
          child: PageView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: ClipRRect(
                      child: FadeInImage.assetNetwork(
                          placeholder: 'images/test1.png',
                          image:
                              "http://img5.mtime.cn/mt/2019/06/28/141445.67206086_1280X720X2.jpg",
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(8.0)),
                );
              },
              itemCount: 8)),
      //
      SizedBox(height: 15),
      //
      Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('筛选条件：',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600))),
      //
      SizedBox(height: 10),
      //
      Container(
          height: 20,
          margin: const EdgeInsets.only(left: 10),
          child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(width: 7);
              },
              itemBuilder: (context, index) {
                return Text('澳大利亚',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        fontSize: 12));
              },
              itemCount: 30,
              scrollDirection: Axis.horizontal)),
      //
      SizedBox(height: 10),
      //
      Container(
          height: 20,
          margin: const EdgeInsets.only(left: 10),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Text('喜剧',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600));
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 7);
              },
              itemCount: 30,
              scrollDirection: Axis.horizontal)),
      //
      SizedBox(height: 10),
      //
      Container(
          height: 20,
          margin: const EdgeInsets.only(left: 10),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Text('2002',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic));
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 7);
              },
              itemCount: 30)),
      //
      Padding(
          padding: const EdgeInsets.only(left: 3, right: 3),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  crossAxisCount: 3,
                  childAspectRatio: 0.75),
              itemCount: 50,
              shrinkWrap: true,
              //important
              scrollDirection: Axis.vertical,
              //important
              physics: NeverScrollableScrollPhysics(),
              //important
              itemBuilder: (context, index) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Image.network(
                        'http://img5.mtime.cn/mt/2018/12/04/160518.62113167_1280X720X2.jpg',
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high));
              }))
    ]);
  }
}
