import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  //
  Widget _createCommentItem() {
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
                      "http://img32.mtime.cn/up/2013/08/13/094117.18753126_128X128.jpg",
                      scale: 15)), //这个图片不加expand，否则会拉伸
              SizedBox(width: 10),
              Expanded(
                  flex: 3,
                  child: Text('我是高原心',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.2))),
              Expanded(
                  flex: 1,
                  child: Text("评分：5.4",
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
          Text("黑道追杀杀人魔",
              style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 1.3,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          SizedBox(height: 10),
          //
          Text(
            '乍一听，《恶人传》像那种以黑帮或黑色政治人物为主角的传记类电影。 但电影并不是什么纪传体，而是一部常见的韩式犯罪类型片。有意思的是，电影在类型化上做了小小创新，也成为了整部《恶人传》最吸引人的地方。 想想看吧，在过往的韩国电影里，痞气的警察见过，暴力的黑社会见过，变态连环杀人犯也见过，这些类型化角色两两搭配也常出好戏，可是把这三种角色联系在一起呢？是不是新鲜感立刻就来了？ 《恶人传》就是如此，本来...',
            style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                letterSpacing: 1.1,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 10),
          //
          Container(
              width: double.infinity,
              height: 20,
              padding: const EdgeInsets.all(3),
              margin: const EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.black12))
        ],
      ),
    );
  }
}
