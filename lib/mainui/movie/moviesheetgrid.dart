import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieSheetGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.only(top: 15, left: 3, right: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CupertinoSegmentedControl(
            borderColor: Colors.black87,
            selectedColor: Colors.black87,
            unselectedColor: Colors.white,
            pressedColor: Colors.black26,
            onValueChanged: (value) {},
            children: {
              1: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  child: Text("测试一部")),
              2: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  child: Text("测试二部")),
              3: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  child: Text("测试三部")),
              4: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  child: Text("测试四部")),
            },
          ),
          SizedBox(height: 15),
          //
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 3.0,
                    childAspectRatio: 0.55,//一定要设置这个值，否则的话，默认是1.0，就是正方形。
                    crossAxisCount: 4),
                itemCount: 195,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 200,
                    child: Column(
                      children: <Widget>[
                        Image.network(
                            "http://img5.mtime.cn/mt/2019/06/04/100310.95313713_1280X720X2.jpg",
                            height: 150,
                            width: 110,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high),
                        SizedBox(height: 5),
                        Text("我们一起学猫叫",
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
