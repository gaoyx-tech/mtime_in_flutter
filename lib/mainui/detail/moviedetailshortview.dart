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
                    child: Text('< 返回',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500)))),
            automaticallyImplyLeading: false,
            title: Text('所有短评',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal))),
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
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
            Row(
              children: <Widget>[
                Image.network(model.getListData()[index].caimg,
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high),
                SizedBox(width: 15),
                Text(model.getListData()[index].ca,
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14)),
                SizedBox(width: 15),
                Text("评分：${model.getListData()[index].cr}",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 13))
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            SizedBox(height: 15),
            //
            Text(model.getListData()[index].ce,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontStyle: FontStyle.normal),
                maxLines: 10),
            //
            SizedBox(height: 15),
            Text(model.getListData()[index].cd.toString(),
                style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w300,
                    fontSize: 13))
          ]),
      padding: const EdgeInsets.all(5),
      color: Colors.white,
    );
  }
}
