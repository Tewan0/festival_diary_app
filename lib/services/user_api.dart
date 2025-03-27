//user_api.dart
// ignore_for_file: empty_catches, unnecessary_brace_in_string_interps, avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:festival_diary_app/models/user.dart'; //แพ็กเกจที่รวบรวมคำสั่งที่เราใช้ติดต่อ API ที่ Backend Server
class UserAPI{
  //สร้าง object dio เพื่อใช้เป็นตัวที่ติดต่อ API ที่ Backend Server
  final Dio dio = Dio();

  //สร้าง method เรียกใช้ API ลงทะเบียน (เพิ่มข้อมูล API)
  Future<bool> registerUser(User user, File? userFile) async {
    try {
      //เอาข้อมูลใส่ FormData
      final formData = FormData.fromMap({
        'userFullname': user.userFullname,
        'userName': user.userName,
        'userPassword': user.userPassword,
        if(userFile != null)
        'userImage': await MultipartFile.fromFile(
          userFile.path,
          filename: userFile.path.split('/').last,
          contentType: DioMediaType('image', userFile.path.split('.').last),
          ),
      });

      //เอาข้อมูลใน FormData ส่งไปผ่าน API ตาม Endpoint ที่กำหนดไว้
      final responseData = await dio.post(
        'http://172.17.34.22:9898/user/',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      //หลังจากทำงานเสร็จ ณ ที่นี้ตรวจสอบผลการทำงานจาก responseData
      if (responseData.statusCode == 201) {
        //แปลว่าเพิ่มสำเร็จ
        return true;
      } else {
        return false;
      }
    }catch(err){
      print('Exception: ${err}');
      return false;
    }
  }
}