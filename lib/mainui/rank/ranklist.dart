import 'package:flutter/material.dart';
import 'package:mtime_in_flutter/mainui/rank/ranknationlist.dart';

class RankList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.black87,
              unselectedLabelColor: Colors.black54,
              labelColor: Colors.black87,
              labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              unselectedLabelStyle:
                  TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              tabs: <Widget>[
                Tab(text: '内地票房榜'),
                Tab(text: '北美票房榜'),
                Tab(text: '全球票房榜'),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              RankNationList(sRequestNumber: "48266"),
              RankNationList(sRequestNumber: "48267"),
              RankNationList(sRequestNumber: "48268"),
            ],
          )),
    );
  }
}
