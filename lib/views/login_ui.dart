// ignore_for_file: sort_child_properties_last

import 'dart:math';

import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/views/register_ui.dart';
import 'package:flutter/material.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userPasswordCtrl = TextEditingController();

  bool isShowUserPassword = true;

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
                  SizedBox(height: 50.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/icon.png',
                      width: 120,
                    ),
                  ),
                  SizedBox(height: 50.0),
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
                      alignment: Alignment.centerLeft, child: Text('รหัสผ่าน')),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: userPasswordCtrl,
                    obscureText: isShowUserPassword,
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
                        icon: isShowUserPassword == true
                            ? Icon(
                                Icons.visibility_off,
                              )
                            : Icon(
                                Icons.visibility,
                              ),
                        onPressed: () {
                          setState(() {
                            isShowUserPassword = !isShowUserPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () {
                      //Validate UI
                      if (userNameCtrl.text.length == 0) {
                        showWraningSnakeBar(context, 'กรุณากรอกชื่อผู้ใช้');
                      } else if (userPasswordCtrl.text.length == 0) {
                        showWraningSnakeBar(context, 'กรุณากรอกรหัสผ่าน');
                      }else {
                        //ส่งชื่อผู้ใช้และรหัสผ่านไปยัง API เพื่อตรวจสอบ
                        User user = User(
                          userName: userNameCtrl.text,
                          userPassword: userPasswordCtrl.text,
                        );
                        //เรียกใช้ checkLogin()
                        user = await UserAPI().checklogin(user);
                        if (user.userId != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeUI(user: user),
                            ),
                          );
                        }else{
                          showWraningSnakeBar(context, 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง');
                        }
                      }
                    },
                    child: Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(mainColor),
                      fixedSize: Size(
                        MediaQuery.of(context).size.width,
                        60,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ยังไม่มีบัญชี?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterUI()),
                          );
                        },
                        child: Text(
                          'สมัครสมาชิก',
                          style: TextStyle(
                            color: Color(mainColor),
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    'Copyright © 2025',
                  ),
                  Text(
                    'Created by Tewan DTI-SAU',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
