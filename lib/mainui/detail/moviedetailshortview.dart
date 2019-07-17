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
            title: Text('影片所有短评',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic))),
        body: ShortListView(sMovieId: movieId),
      ),
    );
  }
}

// ignore: must_be_immutable
class ShortListView extends StatelessWidget {
  final String sMovieId;
  ShortReviewModel model;
  int pageIndex = 1;
  ScrollController _scrollController = ScrollController();

  ShortListView({Key key, this.sMovieId}) : super(key: key) {
    //load more key point
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        model.getNetData(sMovieId, ++pageIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //获取model,不判空，会重复添加
    if (model == null) {
      model = Provider.of<ShortReviewModel>(context);
      model.getNetData(sMovieId, pageIndex);
    }
    //
    return ListView.separated(
        itemBuilder: (context, int index) {
          if (index == model.getListData().length) {
            return Container(
                width: double.infinity,
                height: 40,
                alignment: Alignment.center,
                child: Text('加载更多中....',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w300)));
          } else
            return _createReviewItem(index);
        },
        separatorBuilder: (context, int index) =>
            Divider(height: 1, color: Colors.grey),
        controller: _scrollController,
        itemCount: model.getListData().length + 1);
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
                    width: 25,
                    height: 25,
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
