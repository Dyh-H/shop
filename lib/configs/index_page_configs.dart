import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/category_page.dart';
import 'package:shop/pages/home_page.dart';
import 'package:shop/pages/member_page.dart';

final List<BottomNavigationBarItem> bottomTabs = [
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.home),
    title: Text("首页"),
  ),
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.search),
    title: Text("分类"),
  ),
  BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车')
  ),
  BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心')
  ),
];

final List<Widget> page=[
  HomePage(),
  CategoryPage(),
  CartPage(),
  MemberPage()

];

