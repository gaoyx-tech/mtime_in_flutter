import 'package:flutter/material.dart';
import 'package:mtime_in_flutter/mainui/movie/moviecominglist.dart';
import 'movienowlist.dart';
import 'moviecominglist.dart';
import 'moviesheetgrid.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
                color: Colors.black54),
          ],
          title: TabBar(
            // The color of selected tab labels.
            labelColor: Colors.black87,
            // The color of unselected tab labels.
            unselectedLabelColor: Colors.black38,
            // The color of the line that appears below the selected tab
            indicatorColor: Colors.black87,
            labelStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: <Widget>[
              Tab(text: "正在热映"),
              Tab(text: "即将上映"),
              Tab(text: "推荐片单"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            //movie now
            MovieNowListWidget(),
            //movie coming
            MovieComingListWidget(),
            //movie recommend all
            MovieSheetGrid()
          ],
        ),
      ),
    );
  }
}
