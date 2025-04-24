// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:festival_diary_app/constants/baseURL_constants.dart';
import 'package:festival_diary_app/models/fest.dart';
import 'package:festival_diary_app/models/user.dart';

class FestApi {
  final Dio dio = Dio();

  Future<bool> insertFest(User user, File? userFile) async {
    try {
      //เอาข้อมูลใส่ FormData
      final formData = FormData.fromMap({
        'userFullname': user.userFullname,
        'userName': user.userName,
        'userPassword': user.userPassword,
        if (userFile != null)
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
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      //หลังจากทำงานเสร็จ ณ ที่นี้ตรวจสอบผลการทำงานจาก responseData
      if (responseData.statusCode == 201) {
        //แปลว่าเพิ่มสำเร็จ
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Exception: ${err}');
      return false;
    }
  }

  Future<List<Fest>> getAllFestByUser(int userId) async {
    try {
      final responseData = await dio.get('${baseURL}/fest/${userId}');

      if (responseData.statusCode == 200) {
        print('Response: ${responseData.data}');
        return (responseData.data["info"] as List)
            .map((e) => Fest.fromJson(e))
            .toList();
      } else {
        return <Fest>[];
      }
    } catch (err) {
      print('Exception: ${err}');
      return <Fest>[];
    }
  }

  //สร้างเมธอดเรียกใช้ API สำหรับการลบข้อมูล fest
  Future<bool> deleteFest(int festId) async {
    try {
      final responseData = await dio.delete('${baseURL}/fest/${festId}');

      if (responseData.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Exception: ${err}');
      return false;
    }
  }

  Future<bool> updateFest(User user, File? userFile) async {
    try {
      //เอาข้อมูลใส่ FormData
      final formData = FormData.fromMap({
        'userFullname': user.userFullname,
        'userName': user.userName,
        'userPassword': user.userPassword,
        if (userFile != null)
          'userImage': await MultipartFile.fromFile(
            userFile.path,
            filename: userFile.path.split('/').last,
            contentType: DioMediaType('image', userFile.path.split('.').last),
          ),
      });

      //เอาข้อมูลใน FormData ส่งไปผ่าน API ตาม Endpoint ที่กำหนดไว้
      final responseData = await dio.put(
        '${baseURL}/user/${user.userId}',
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      //หลังจากทำงานเสร็จ ณ ที่นี้ตรวจสอบผลการทำงานจาก responseData
      if (responseData.statusCode == 200) {
        //แปลว่าเพิ่มสำเร็จ
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Exception: ${err}');
      return false;
    }
  }
}
