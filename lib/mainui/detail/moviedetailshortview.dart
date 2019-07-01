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
      ),
    );
  }
}
