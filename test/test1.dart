import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:shop/service/service_method.dart';

void main(List<String> args) {
  // Hot();
}

get(String text) async{
   String url="http://apis.juhe.cn/mobile/get";
   Response response;
   Dio dio=new Dio();
   Map<String,dynamic> query={"phone":text,"key":"2d556c5d92397911cfa43bf07706242f"};
   response=await dio.get(url,queryParameters: query);
  //  var a=json.decode(response.data);
  //  print(a);
   print(response.data);
   print(response.data["result"]);
   print(response.data["result"]["province"]);
   print(response.data["result"]["city"]);
}