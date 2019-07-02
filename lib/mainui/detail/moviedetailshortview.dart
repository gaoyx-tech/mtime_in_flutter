import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'moviedetailbean.dart';

class MovieDetailShortView extends StatelessWidget {
  //
  final String movieId;

  MovieDetailShortView({this.movieId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => ShortReviewModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black87,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                  child: Text('<返回',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500)))),
          automaticallyImplyLeading: false,
          title: Text(
            '所有短评',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic),
          ),
        ),
        body: ShortListView(sMovieId: movieId),
      ),
    );
  }
}

// ignore: must_be_immutable
class ShortListView extends StatelessWidget {
  final String sMovieId;
  ShortReviewModel model;

  ShortListView({this.sMovieId});

  @override
  Widget build(BuildContext context) {
    //获取model
    model = Provider.of<ShortReviewModel>(context);
    model.getNetData(sMovieId, 1);
    //
    return ListView.separated(
        itemBuilder: (context, int index) {
          return _createReviewItem(index);
        },
        separatorBuilder: (context, int index) =>
            Divider(height: 1, color: Colors.grey),
        itemCount: model.getListData().length);
  }

  Widget _createReviewItem(int index) {
    return Container(child: Text(model.getListData()[index].ce));
  }
}
