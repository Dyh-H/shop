import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../service/service_method.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FutureBuilder(
          future: getHomePageContent(),
          builder: (context,snapshot){
            if (snapshot.hasData) {
              var data=json.decode(snapshot.data.toString());
              List<Map> swiperDataList=(data['data']['slides'] as List).cast();
              return SwiperDiy(swiperDataList: swiperDataList);
            } else {
              return Center(child: Text("加载中..."),);
            }
          }
          )
      ],
    );
  }
}










class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Swiper(
        outer: true,
        itemHeight: 100,
        itemWidth: 200,
        itemCount: swiperDataList.length,
        itemBuilder: (BuildContext context,int index){
          return Image.network("${swiperDataList[index]['image']}",fit:BoxFit.fill);
        },
        pagination: new SwiperPagination(),
        autoplay: true,
        ),
    );
  }
}