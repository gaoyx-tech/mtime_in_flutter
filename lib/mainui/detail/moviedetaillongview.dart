import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'moviedetailbean.dart';

// ignore: must_be_immutable
class MovieDetailLongView extends StatelessWidget {
  //
  String sMovieId;

  //
  MovieDetailLongView(this.sMovieId);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        builder: (BuildContext context) => LongReviewModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              '影片所有长评',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          body: LongReviewListView(
            movieId: sMovieId,
          ),
        ));
  }
}

// ignore: must_be_immutable
class LongReviewListView extends StatelessWidget {
  //
  LongReviewModel longModel;
  int pageIndex = 1;
  final String movieId;

  //
  LongReviewListView({this.movieId});

  @override
  Widget build(BuildContext context) {
    if (longModel == null) {
      longModel = Provider.of<LongReviewModel>(context);
      longModel.getNetData(movieId, pageIndex);
    }
    if (longModel.getLongData().length == 0) {
      return Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              strokeWidth: 1.5));
    }
    //
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) =>
            _createLongReviewWidget(index),
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 1, color: Colors.grey),
        itemCount: longModel.getLongData().length);
  }

  Widget _createLongReviewWidget(int index) {
    return Padding(
        padding: const EdgeInsets.only(left: 4, right: 4, top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                    backgroundImage: NetworkImage(
                        longModel.getLongData()[index].headurl,
                        scale: 20)),
                SizedBox(width: 10),
                Text(longModel.getLongData()[index].nickname,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.w300)),
                SizedBox(width: 20),
                Text('评分：${longModel.getLongData()[index].rating}',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400))
              ],
            ),
            SizedBox(height: 10),
            //
            Text(longModel.getLongData()[index].title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 15)),
            SizedBox(height: 10),
            //
            Text(longModel.getLongData()[index].content,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            SizedBox(height: 10),
            //
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              Text(longModel.getLongData()[index].modifyTime.toString(),
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                      fontWeight: FontWeight.w300))
            ])
          ],
        ));
  }
}
