// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/models/user.dart';
import 'package:festival_diary_app/services/user_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({super.key});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  //สร้างตัวควบคุม TextFile
  TextEditingController userFullnameCtrl = TextEditingController();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userPasswordCtrl = TextEditingController();

  //สร้างตัวแปรควบคุมการเปิดปิดตากับช่องป้อนรหัสผ่าน
  bool isVisible = true;

  //ตัวแปรเก็บรูปที่ถ่าย
  File? userFile;

  //method สำหรับเปิดกล้องถ่ายรูป
  Future<void> openCamera() async {
    //เปิดกล้องถ่ายรูป
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    //ตรวจสอบว่าได้ถ่ายไหม
    if (image == null) return;

    //หากถ่ายให้เอารูปที่ถ่ายไปเก็บในตัวแปรที่สร้างไว้โดยการแปลงรูปที่ถ่ายให้เป็น File
    setState(() {
      userFile = File(image.path);
    });
  }

  //method แสดง SnakeBar คำเตือน
  showWraningSnakeBar(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Align(
          child: Text(
            msg,
          ),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ),
    );
  }

  showCompleteSnakeBar(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Align(
          child: Text(
            msg,
          ),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Text(
          'Festival Diary',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          //แตะตรงตำแหน่งใดก็ตามจะทำให้ keyboard หายไป
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 40.0),
                  Text(
                    'สมัครสมาชิก',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  InkWell(
                    onTap: () async {
                      //เรียกใช้งาน method เปิดกล้องถ่ายรูป
                      await openCamera();
                    },
                    child:
                        userFile == null
                            ? Icon(
                              Icons.person_add_alt_1,
                              size: 150,
                              color: Color(mainColor),
                            )
                            : Image.file(
                              userFile!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('ชื่อ-สกุล'),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: userFullnameCtrl,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(mainColor),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(mainColor),
                          width: 2,
                        ),
                      ),
                      prefixIcon: Icon(Icons.person_add_alt_1),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('ชื่อผู้ใช้'),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: userNameCtrl,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(mainColor),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(mainColor),
                          width: 2,
                        ),
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('รหัสผ่าน'),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: userPasswordCtrl,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(mainColor),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(mainColor),
                          width: 2,
                        ),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isVisible == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () async {
                      //ส่งข้อมูลไปบันทึกที่ DB ผ่าน API ส่วน Backend ที่สร้างไว้
                      //Validate UI
                      if (userFullnameCtrl.text.trim().isEmpty) {
                        showWraningSnakeBar(
                          context,
                          'กรุณากรอกชื่อ-สกุล',
                        );
                      }else if (userNameCtrl.text.trim().isEmpty) {
                        showWraningSnakeBar(
                          context,
                          'กรุณากรอกชื่อผู้ใช้',
                        );
                      }else if (userPasswordCtrl.text.trim().isEmpty) {
                        showWraningSnakeBar(
                          context,
                          'กรุณากรอกรหัสผ่าน',
                        );
                      }else{
                        //แพ็กข้อมูล แล้วส่งผ่าน API ไปบันทึกลง DB
                        //แพ็กข้อมูล
                        User user = User(
                          userFullname: userFullnameCtrl.text.trim(),
                          userName: userNameCtrl.text.trim(),
                          userPassword: userPasswordCtrl.text.trim(),
                        );
                        //ส่งผ่าน API ไปบันทึกลง DB
                        if(await UserAPI().registerUser(user, userFile)){
                          showCompleteSnakeBar(context, 'สมัครสมาชิกสำเร็จ');
                          Navigator.pop(context);
                        }else{
                          showCompleteSnakeBar(context, 'สมัครสมาชิกไม่สำเร็จ');
                        };
                      }
                    },
                    child: Text(
                      'สมัครสมาชิก',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(mainColor),
                      fixedSize: Size(MediaQuery.of(context).size.width, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
