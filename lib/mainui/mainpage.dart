import 'package:flutter/material.dart';
import 'package:mtime_in_flutter/mainui/movie/movielist.dart';
import 'package:mtime_in_flutter/mainui/rank/ranklist.dart';
import 'package:mtime_in_flutter/mainui/me/me.dart';
import 'package:mtime_in_flutter/mainui/discovery/discoverlist.dart';

class MainPageBottomTabWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageBottomState();
  }
}

class MainPageBottomState extends State<MainPageBottomTabWidget> {
  int _pageIndex = 0;
  List _listWidget = List<Widget>();

  @override
  void initState() {
    _listWidget
      ..add(MovieList())
      ..add(DiscoveryList())
      ..add(RankList())
      ..add(Me());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        backgroundColor: Colors.white,
        iconSize: 20,
        unselectedFontSize: 14,
        selectedFontSize: 14,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.black38,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _pageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), title: Text('电影')),
          BottomNavigationBarItem(
              icon: Icon(Icons.find_replace), title: Text("发现")),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), title: Text('排行榜')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), title: Text("我的")),
        ],
      ),
    );
  }
}
