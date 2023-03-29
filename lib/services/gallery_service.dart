import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo_getx/utilities/const.dart';
import 'package:get/get.dart' as GetX;

class GalleryServices {
  static Future<bool> creates(FormData data) async {
    try {

      // var headers = {
      //   'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzExMDk4MDkzLCJpYXQiOjE2Nzk1NjIwOTMsImp0aSI6IjI5ZTg0N2RiNTZhZDRlY2E4ZTE5ODJhYmY5NDI0Mzk2IiwidXNlcl9pZCI6MX0.53QmlbzahgrHOrHi_9lgCphkRkwtwMkfp0mbX_3Tjnk',
      //   'Cookie': 'csrftoken=KVitXxcngMKXnudgDznmdHDmSPNKEHmu; sessionid=ppywqfl3s81mi7nl09cjy75wv7ilgd1w'
      // };
      //
      //
      //
      // Dio dio =  Dio();
      // dio.options.headers['content-Type'] = 'application/json';
      // dio.options.headers["authorization"] = "token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzExMDk4MDkzLCJpYXQiOjE2Nzk1NjIwOTMsImp0aSI6IjI5ZTg0N2RiNTZhZDRlY2E4ZTE5ODJhYmY5NDI0Mzk2IiwidXNlcl9pZCI6MX0.53QmlbzahgrHOrHi_9lgCphkRkwtwMkfp0mbX_3Tjnk}";
      // Response response = await dio.post("https://api.topup.vikncodes.in/api/v1/products/create-product/", data: data);



// print(response.data);
// print(response.statusCode);

      Response responsed =
      await Dio().post(
        "https://api.topup.vikncodes.in/api/v1/products/create-product/",
        options: Options(
          headers: {  'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzExMDk4MDkzLCJpYXQiOjE2Nzk1NjIwOTMsImp0aSI6IjI5ZTg0N2RiNTZhZDRlY2E4ZTE5ODJhYmY5NDI0Mzk2IiwidXNlcl9pZCI6MX0.53QmlbzahgrHOrHi_9lgCphkRkwtwMkfp0mbX_3Tjnk',
            'Content-Type': 'application/json',
            'Cookie': 'csrftoken=KVitXxcngMKXnudgDznmdHDmSPNKEHmu; sessionid=ppywqfl3s81mi7nl09cjy75wv7ilgd1w'},
        ),
        data: data,
      );

      print(responsed.statusCode);
      if(responsed.statusCode==201){
        GetX.Get.snackbar('Successfully','New Profile Added',
            backgroundColor: Colors.white,
            duration: Duration(seconds: 4),
            animationDuration: Duration(milliseconds: 900),
            margin: EdgeInsets.only(top: 5, left: 10, right: 10)
        );
        return true;
      }
      return false;
    } catch(e){
      print(e.toString());
      return false;
    }
  }
  static Future<bool> create(FormData data) async {
    try {
      Response response =
      await Dio().post(
        "$baseURL/galleries",
        data: data,
      );
      if(response.statusCode==201){
        GetX.Get.snackbar('Successfully','New Profile Added',
            backgroundColor: Colors.white,
            duration: Duration(seconds: 4),
            animationDuration: Duration(milliseconds: 900),
            margin: EdgeInsets.only(top: 5, left: 10, right: 10)
        );
        return true;
      }
      return false;
    } catch(e){
      return false;
    }
  }

  static Future<dynamic> fetch() async {
    try{
      var response = await Dio().get(
          "$baseURL/galleries"
      ).timeout(Duration(seconds: 10));
      if(response.statusCode == 200) {
        return response.data;
      }
      else{
        // AppSnack.showSnack('Login fail','Invalid pin');
        return null;
      }
    } catch(e){
      return null;
    }
  }
}
