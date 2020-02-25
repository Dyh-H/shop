//入口文件

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import './pages/index_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(   //widget本身的定义，为嵌套提供了可能性
      child: MaterialApp(
        title: "百姓生活+",
        debugShowCheckedModeBanner: false,   //右上角debug
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}



