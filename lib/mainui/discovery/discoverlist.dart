import 'package:flutter/material.dart';
import 'package:mtime_in_flutter/mainui/discovery/cinemalist.dart';
import 'package:mtime_in_flutter/mainui/discovery/commentlist.dart';
import 'package:mtime_in_flutter/mainui/discovery/discoverylistbean.dart';
import 'package:mtime_in_flutter/mainui/discovery/previewlist.dart';
import 'package:provider/provider.dart';

class DiscoveryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<TrailerBloc>.value(
              notifier: TrailerBloc(),
            ),
            ChangeNotifierProvider<CommentBloc>.value(
              notifier: CommentBloc(),
            )
          ],
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: TabBar(
                tabs: <Widget>[
                  Tab(text: "预告片"),
                  Tab(text: "影评"),
                  Tab(text: "影院")
                ],
                indicatorColor: Colors.black87,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.black38,
                labelStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                unselectedLabelStyle:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
            body: TabBarView(
              children: <Widget>[PreviewList(), CommentList(), CinemaList()],
            ),
          ),
        ));
  }
}
