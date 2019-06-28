import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'discoverylistbean.dart';

class CinemaList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CinemaListState();
  }
}

class CinemaListState extends State<CinemaList> {
  List<CinemaItem> _list = List<CinemaItem>();

  //
  Widget _createCinemaItem(int index) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 120,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          //横向3：1空间
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_list[index].cinameName,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontSize: 16)),
                  //
                  Text(_list[index].address,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                  //
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: _getCinemaType(index))
                ],
              )),
          Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.center,
                  child: Text("好评度：${_list[index].ratingFinal}",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500))))
        ],
      ),
    );
  }

  //vip,2d,3d,imax.....
  List<Widget> _getCinemaType(int index) {
    List<Widget> types = new List<Widget>();
    //
    List<String> sTypes = new List<String>();
    CinemaFeature feature = _list[index].feature;
    if (feature.has3D == 1) sTypes.add("3D");
    if (feature.hasFeature4D == 1) sTypes.add("4D");
    if (feature.hasFeature4K == 1) sTypes.add("4K");
    if (feature.hasFeatureDolby == 1) sTypes.add("Dolby");
    if (feature.hasFeatureHuge == 1) sTypes.add("中国巨幕");
    if (feature.hasIMAX == 1) sTypes.add("IMAX");
    if (feature.hasLoveseat == 1) sTypes.add("情侣座");
    if (feature.hasPark == 1) sTypes.add("可停车");
    if (feature.hasScreenX == 1) sTypes.add("ScreenX");
    if (feature.hasServiceTicket == 1) sTypes.add("网上购票");
    if (feature.hasSphereX == 1) sTypes.add("SphereX");
    if (feature.hasVIP == 1) sTypes.add("VIP");
    if (feature.hasWifi == 1) sTypes.add("WIFI");
    //
    for (var i = 0; i < sTypes.length; ++i) {
      types.add(Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(4.0)),
          padding: const EdgeInsets.only(
              left: 2.0, right: 2.0, top: 2.0, bottom: 2.0),
          margin: const EdgeInsets.only(right: 2),
          child: Text(sTypes[i],
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w100))));
    }
    return types;
  }

  @override
  void initState() {
    super.initState();
    _getNetRequestData();
  }

  void _getNetRequestData() async {
    Response response = await new Dio().get(
        "https://ticket-api-m.mtime.cn/onlineCinemasByCity.api",
        queryParameters: {"locationId": "290"});
    var jsonStr = json.decode(response.toString());
    List<CinemaItem> items =
        CinemaListData.fromJson(jsonStr["data"]["cinemaList"]).cinemaList;
    //
    setState(() {
      _list = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _createCinemaItem(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 1, color: Colors.black26);
        },
        itemCount: _list.length);
  }
}
