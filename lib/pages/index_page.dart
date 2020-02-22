import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../configs/index_page_configs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int currentIndex=0; //此参数必须放在build方法外

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活"),
      ),
      bottomNavigationBar: Container(
        //可以设置高度用来调整底部导航栏高度
        child: BottomNavigationBar(
          items: bottomTabs,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          // onTap:ontap,
          onTap: (value){
            currentIndex=value;
            setState(() {
            });
          },
          // fixedColor: Colors.yellow,  图标颜色
          // iconSize: 18.0,
          // unselectedFontSize: 9.0,
          // selectedFontSize: 9.0,
          
          ),
      ),
      body: page[currentIndex],
    );
  }
  
}