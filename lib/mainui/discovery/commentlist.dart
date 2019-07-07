import 'dart:math';

import 'package:flutter/material.dart';

class CommentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _createCommentItem();
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 1, color: Colors.grey);
        },
        itemCount: 30);
  }

  Widget _createCommentItem() {
    return Container(
      padding: const EdgeInsets.only(left: 7, top: 5, right: 5, bottom: 7),
    );
  }
}
