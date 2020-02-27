import 'package:dio/dio.dart';
import 'package:shop/configs/service_url.dart';
import 'dart:convert';

import 'package:shop/service/service_method.dart';

void main(List<String> args) {
  // Hot();
  post();
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

post()async{
  var i=5;
  Dio dio=new Dio();
  var formdata={"page":5};
  // dio.options.contentType="application/x-www-form-urlencoded";
  await dio.post(servicePath["homePageBelowConten"],data: formdata).then((val){
    print(val);
  });
}