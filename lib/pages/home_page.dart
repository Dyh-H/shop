import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../service/service_method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return 
      FutureBuilder(
                future: getHomePageContent(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = json.decode(snapshot.data.toString());
                    List<Map> swiperDataList =
                        (data['data']['slides'] as List).cast();
                    List<Map> navigatorList =
                        (data['data']['category'] as List).cast();
                    String url = data['data']['advertesPicture']['PICTURE_ADDRESS'];
                    String  leaderImage= data['data']['shopInfo']['leaderImage'];  //店长图片
                    String  leaderPhone = data['data']['shopInfo']['leaderPhone'];
                    List<Map> recommendList = (data['data']['recommend'] as List).cast(); // 商品推荐
                    return  
                       ListView(
                          children: <Widget>[
                            SwiperDiy(swiperDataList: swiperDataList,),
                            TopNavigator(navigatorList: navigatorList,),
                            ADbanner(url: url,),
                            LaunchURL(Imageurl: leaderImage,Tel: leaderPhone,),
                            Recommand(recommendList: recommendList,),
                          ],
                        
                    );
                    
                  } else {
                    return Center(
                      child: Text("加载中..."),
                    );
                  }
                }
    );
        
  }
}


//轮播图区域
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Container(
      height: ScreenUtil().setHeight(333),
      // height: 300,
      // width: ScreenUtil().setWidth(400), //假设屏幕是760，那么宽度为400
      child: Swiper(
        // outer: true,
        itemHeight: 100,
        itemWidth: 200,
        itemCount: swiperDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${swiperDataList[index]['image']}",
              fit: BoxFit.fill);
        },
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//导航栏区域
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({Key key, this.navigatorList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(), //禁止gridview滑动
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }

  Widget _gridViewItemUI(BuildContext context, item) {
    // ScreenUtil.init(context,width: 750,height: 1334,allowFontScaling: false);
    return InkWell(
      onTap: () {
        print("点击了导航");
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }
}

//广告区域编写
class ADbanner extends StatelessWidget {
  final String url;
  ADbanner({Key key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        url,
      ),
    );
  }
}





//拨打电话模块
class LaunchURL extends StatelessWidget {
  final String Imageurl;
  final String Tel;
  LaunchURL({Key key,this.Imageurl,this.Tel}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Image.network(Imageurl),
        onTap: _launchURL,
      ),
    );
  }

  _launchURL() async {
  String url ="tel://"+Tel;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "Could not find utl";
  }
}
}








//商品推荐
class Recommand extends StatelessWidget {
  final List recommendList;

  Recommand({Key key, this.recommendList}) : super(key: key);

  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _itemTitle(),
          _recommedList()
        ],
        ),
    );
  }

  Widget _itemTitle(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5,color: Colors.black12)
        )
      ),
      child: Text("商品推荐",style: TextStyle(color: Colors.pink),),
    );
  }

  Widget _item(index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration:BoxDecoration(
          color:Colors.white,
          border:Border(
            left: BorderSide(width:0.5,color:Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color:Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }
  //横向列表
  Widget _recommedList(){

      return Container(
        height: ScreenUtil().setHeight(345),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context,index){
            return _item(index);
          },
        ),
      );
  }
}