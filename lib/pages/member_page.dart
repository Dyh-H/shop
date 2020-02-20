import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MemberPage extends StatefulWidget {
  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Swiper(
        itemWidth: 300,
        loop: true, //是否无限循环
        autoplay: true,  //自动播放
        itemCount: 5,
        duration: 300,  //图片切换时的动画
        autoplayDelay: 3000,   //自动播放延迟时间
        autoplayDisableOnInteraction: false,  //用户拖拽时是否停止自动播放
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2942945378,442701149&fm=26&gp=0.jpg",
          );
        },
        // pagination: SwiperPagination(
        //   alignment: Alignment.bottomCenter,
        //   builder: SwiperCustomPagination(
        //     builder: (BuildContext context,SwiperPluginConfig config){
        //       return Text("hello");
        //     }
        //     )
        // ),
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
        // viewportFraction: 0.8,  //轮播图总图（多张图片合成一张图片）比例
        // scale: 0.9,   //单个图片放大缩小比例
        // layout: SwiperLayout.STACK, //轮播布局方式
        controller: SwiperController(
        ),
      ),
    );
  }
}
