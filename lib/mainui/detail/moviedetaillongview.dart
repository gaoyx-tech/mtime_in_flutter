import 'package:flutter/material.dart';

class MovieDetailLongView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '影片长评',
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
    );
  }
}
