import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtime_in_flutter/mainui/discovery/discoverylistbean.dart';
import 'package:provider/provider.dart';
import 'package:mtime_in_flutter/mainui/detail/moviedetail.dart';

// ignore: must_be_immutable
class CommentList extends StatelessWidget {
  CommentBloc _commentRequest;

  @override
  Widget build(BuildContext context) {
    if (_commentRequest == null) {
      _commentRequest = Provider.of<CommentBloc>(context);
      _commentRequest.getNetData();
    }
    //
    if (_commentRequest.getData().length == 0) {
      return Center(
          child: CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black)));
    }
    //
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _createCommentItem(context, index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 1, color: Colors.grey);
        },
        itemCount: _commentRequest.getData().length);
  }

  //
  Widget _createCommentItem(BuildContext context, int index) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                  backgroundImage: NetworkImage(
                      _commentRequest.getData()[index].userImage,
                      scale: 15)),
              //这个图片不加expand，否则会拉伸
              SizedBox(width: 10),
              Expanded(
                  flex: 3,
                  child: Text(_commentRequest.getData()[index].nickname,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.2))),
              Expanded(
                  flex: 1,
                  child: Text("评分：${_commentRequest.getData()[index].rating}",
                      style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w400,
                          color: Colors.deepOrange)))
            ],
          ),
          SizedBox(height: 10),
          //
          Text(_commentRequest.getData()[index].title,
              style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 1.3,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          SizedBox(height: 10),
          //
          Text(
            _commentRequest.getData()[index].summary,
            style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                letterSpacing: 1.1,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 10),
          //
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        maintainState: false,
                        builder: (BuildContext context) {
                          return MovieDetailWidget(
                              sMovieId: _commentRequest
                                  .getData()[index]
                                  .movie
                                  .id
                                  .toString());
                        }));
              },
              child: Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.all(3),
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.network(
                            _commentRequest.getData()[index].movie.image,
                            width: 70,
                            height: 90,
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover),
                        SizedBox(width: 5),
                        //防溢出
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                    _commentRequest
                                        .getData()[index]
                                        .movie
                                        .title,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 14)),
                                SizedBox(height: 7),
                                Text(
                                    _commentRequest
                                        .getData()[index]
                                        .movie
                                        .titleEn,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(height: 7),
                                Text(
                                    '年代：${_commentRequest.getData()[index].movie.year}',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400))
                              ]),
                        )
                      ])))
        ],
      ),
    );
  }
}
