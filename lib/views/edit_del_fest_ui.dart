// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:festival_diary_app/constants/baseURL_constants.dart';
import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/models/fest.dart';
import 'package:festival_diary_app/views/add_fest_ui.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditDelFestUI extends StatefulWidget {
  Fest? fest;

  EditDelFestUI({super.key, required Fest fest});

  @override
  State<EditDelFestUI> createState() => _EditDelFestUIState();
}

class _EditDelFestUIState extends State<EditDelFestUI> {
  //สร้างตัวควบคุม TextFile
  TextEditingController festNameCtrl = TextEditingController();
  TextEditingController festDetailCtrl = TextEditingController();
  TextEditingController festStateCtrl = TextEditingController();
  TextEditingController festCostCtrl = TextEditingController();
  TextEditingController festDayCtrl = TextEditingController();

  showWraningSnakeBar(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Align(alignment: Alignment.center, child: Text(msg)),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  showCompletegSnakeBar(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Align(alignment: Alignment.center, child: Text(msg)),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  //ตัวแปรเก็บรูปที่ถ่าย
  File? userFile;

  File get festFile => userFile!;

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

  @override
  void initState() {
    festNameCtrl.text = widget.fest!.festName!;
    festDetailCtrl.text = widget.fest!.festDetail!;
    festStateCtrl.text = widget.fest!.festState!;
    festCostCtrl.text = widget.fest!.festCost!.toString();
    festDayCtrl.text = widget.fest!.festNumDay!.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Text(
          'ข้อมูล Festival Diary',
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
                    'รายละเอียด Festival',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  InkWell(
                    onTap: () async {
                      //เรียกใช้งาน method เปิดกล้องถ่ายรูป
                      await openCamera();
                    },
                    child:
                        festFile == null
                            ? widget.fest!.festImage! == ''
                                ? Image.asset(
                                  'assets/images/festlogo.png',
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                                : Image.network(
                                  '${baseURL}/images/fests/${widget.fest!.festImage!}',
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
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
                    child: Text(
                      'ชื่อ Festival',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: festNameCtrl,
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
                      prefixIcon: Icon(Icons.mode_of_travel_sharp),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'รายละเอียด',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: festDetailCtrl,
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
                      prefixIcon: Icon(Icons.safety_check),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'สถานที่จัดงาน',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: festStateCtrl,
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
                      prefixIcon: Icon(Icons.flag_circle),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ค่าใช้จ่าย',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: festCostCtrl,
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
                      prefixIcon: Icon(Icons.youtube_searched_for),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'จำนวนวันงาน',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: festDayCtrl,
                    keyboardType: TextInputType.number,
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
                      prefixIcon: Icon(Icons.cable_sharp),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () async {
                      //Validate UI
                      if (festNameCtrl.text.isEmpty) {
                        showWraningSnakeBar(context, 'กรุณากรอกชื่อ Festival');
                      } else if (festDetailCtrl.text.isEmpty) {
                        showWraningSnakeBar(context, 'กรุณากรอกรายละเอียด');
                      } else if (festStateCtrl.text.isEmpty) {
                        showWraningSnakeBar(context, 'กรุณากรอกสถานที่จัดงาน');
                      } else if (festCostCtrl.text.isEmpty) {
                        showWraningSnakeBar(context, 'กรุณากรอกค่าใช้จ่าย');
                      } else if (festDayCtrl.text.isEmpty) {
                        showWraningSnakeBar(context, 'กรุณากรอกจำนวนวันงาน');
                      } else if (userFile == null) {
                        showWraningSnakeBar(
                          context,
                          'กรุณาถ่ายรูป Festival Diary',
                        );
                      } else {
                        Fest fest = Fest(
                          festName: festNameCtrl.text.trim(),
                          festDetail: festDetailCtrl.text.trim(),
                          festState: festStateCtrl.text.trim(),
                          festCost: festCostCtrl.text.trim(),
                          festNumDay: int.parse(festDayCtrl.text.trim()),
                          userId: widget.fest!.userId,
                          festId: widget.fest!.festId,
                        );
                        //ส่งข้อมูลผ่าน API ไปบันทึกลง DB
                        if (await FestAPI().updateFest(fest, festFile)) {
                          showCompletegSnakeBar(
                            context,
                            'บันทึกข้อมูลสำเร็จ',
                          );
                          //แล้วก็เปิดกลับไปหน้า LoginUI()
                          Navigator.pop(context);
                        } else {
                          showCompletegSnakeBar(context, 'บันทึกข้อมูลไม่สำเร็จ');
                        }
                      }
                    },
                    child: Text(
                      'บันทึกแก้ไขงาน Festival',
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
                  ElevatedButton(
                    onPressed: () async {},
                    child: Text(
                      'ลบงาน Festival',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
