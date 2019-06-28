import 'package:flutter/material.dart';

class CommentList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CommentListState();
  }
}

class CommentListState extends State<CommentList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text('2'),
        Text('2'),
        Text('2'),
      ],
    );
  }
}
