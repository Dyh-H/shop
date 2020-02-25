import 'package:dio/dio.dart';
import 'dart:async';

Future getHomePage(url,{formData}) async{
  try {
    print("开始获取数据....");
    Response response;
    Dio dio=new Dio();
    dio.options.contentType="application/x-www-form-urlencoded";
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    if (formData==null) {
      response=await dio.post(url);
    } else {
      response=await dio.post(url,data: formData);
    }
    if (response.statusCode==200) {
      return response.data;
    } else {
      throw Exception("后端接口出现异常请检查代码和服务器情况....");
    }
  } catch (e) {
    return print("ERRor:=====>${e}");
  }
}