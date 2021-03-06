
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shop/configs/service_url.dart';
import '../service/service_method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int i=2;

  @override
  bool get wantKeepAlive => true;

  List<Map> dataList;

  @override
  void initState(){
    super.initState();
    getHomePage(servicePath["homePageBelowConten"]).then((val){
      var a=json.decode(val);
      dataList=(a["data"] as List).cast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getHomePage(servicePath["homePageContext"],formData: {'lon': '115.02932', 'lat': '35.76189'}),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiperDataList = (data['data']['slides'] as List).cast();
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            String url = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['data']['shopInfo']['leaderImage']; //店长图片
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List<Map> recommendList =
                (data['data']['recommend'] as List).cast(); // 商品推荐
            String floor1Title =
                data['data']['floor1Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
            String floor2Title =
                data['data']['floor2Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
            String floor3Title =
                data['data']['floor3Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
            List<Map> floor1 =
                (data['data']['floor1'] as List).cast(); //楼层1商品和图片
            List<Map> floor2 =
                (data['data']['floor2'] as List).cast(); //楼层1商品和图片
            List<Map> floor3 =
                (data['data']['floor3'] as List).cast(); //楼层1商品和图片
            return EasyRefresh(
              child: ListView(
                children: <Widget>[
                  SwiperDiy(swiperDataList: swiperDataList,),
                  TopNavigator(navigatorList: navigatorList,),
                  ADbanner(url: url,),
                  LaunchURL(Imageurl: leaderImage,Tel: leaderPhone,),
                  Recommand(recommendList: recommendList,),
                  FloorTitle(picture_address: floor1Title),
                  FloorContent(floorGoodsList: floor1),
                  FloorTitle(picture_address: floor2Title),
                  FloorContent(floorGoodsList: floor2),
                  FloorTitle(picture_address: floor3Title),
                  FloorContent(floorGoodsList: floor3),
                  Hot(dataList: dataList,),
                ],
              ),
              onRefresh: null,
              topBouncing: false,
              onLoad: ()async{
                print("开始加载...第${i}页");
                var formdata={"page":i};
                await getHomePage(servicePath["homePageBelowConten"],formData: formdata).then((val){
                  var b=json.decode(val.toString());
                  List<Map> newList=(b["data"] as List).cast();
                  setState(() {
                    dataList.addAll(newList);
                    i++;
                  });
                });
              },
              footer: ClassicalFooter(
                enableInfiniteLoad: false,  //是否无限自动加载
                completeDuration: Duration(seconds: 10),  //完成延迟
                float: true,
                loadReadyText: "释放加载...",
                loadedText: "加载完成...",
                loadingText: "正在加载...",
                loadText: "取消加载.."
              ),
            );
          } else {
            return Center(
              child: Text("加载中..."),
            );
          }
        });
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
  LaunchURL({Key key, this.Imageurl, this.Tel}) : super(key: key);
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
    String url = "tel://" + Tel;
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
        children: <Widget>[_itemTitle(), _recommedList()],
      ),
    );
  }

  Widget _itemTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: Text(
        "商品推荐",
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  //横向列表
  Widget _recommedList() {
    return Container(
      height: ScreenUtil().setHeight(345),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }
}

//楼层区域编写
class FloorTitle extends StatelessWidget {
  final String picture_address; // 图片地址
  FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}

class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRow(), _otherGoods()],
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          print('点击了楼层商品');
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}

//火爆区域编写
class Hot extends StatefulWidget {
  final List<Map> dataList;

  Hot({Key key, this.dataList}) : super(key: key);
  
  @override
  _HotState createState() => _HotState();
}

class _HotState extends State<Hot> {
  
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Column(
      children: <Widget>[
        HotTitle(),
        HotContent()
      ],
    );
  }

  Widget HotTitle(){
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text("火爆专区",style: TextStyle(fontSize: 16),),
    );
  }
  Widget HotContent(){
    return Container(
      child: Wrap(
         spacing: 9.0,
         runSpacing: 12.0,
        alignment: WrapAlignment.center,
        children: widget.dataList.map((item){
          return _Item(item["name"], item["image"], item["price"],item["mallPrice"]);
        }).toList()
      ),
    );
  }
  Widget _Item(name,url,price,mallprice){
    return Container(
      decoration: BoxDecoration(
        color:Colors.white,
      ),
      width: ScreenUtil().setWidth(350),
     child: Column(
       children: <Widget>[
         Image.network(url),
         Container(
           padding: EdgeInsets.all(1.0),
           child: Text(name),
         ),
         Container(
           padding: EdgeInsets.fromLTRB(0, 3.0, 0.0, 10.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: <Widget>[
               Text(price.toString()),
               Text(mallprice.toString()),
             ],
           ),
         )
       ],
     ), 
    );
  }
}
