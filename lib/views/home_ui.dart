// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:html';

import 'package:festival_diary_app/constants/baseURL_constants.dart';
import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/models/user.dart';
import 'package:festival_diary_app/views/add_fest_ui.dart';
import 'package:festival_diary_app/views/login_ui.dart';
import 'package:festival_diary_app/views/user_ui.dart';
import 'package:flutter/material.dart';

class HomeUI extends StatefulWidget {
  User? user;
  HomeUI({super.key, this.user});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
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
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginUI(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50.0),
            widget.user!.userImage! == ''
                ? Image.asset(
                  'assets/images/festlogo.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
                : Image.network(
                  '${baseURL}/images/users/${widget.user!.userImage!}',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
            SizedBox(height: 20.0),
            Text(widget.user!.userFullname!, style: TextStyle(fontSize: 18)),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserUI(
                      user: widget.user,
                    ),
                  ),
                ).then((value){
                  setState(() {
                    widget.user = value;
                  });
                });
              },
              child: Text(
                '(Edit Profile)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFestUI(
                userId: widget.user!.userId!,
              ),
            ),
          );
        },
        label: Text(
          'Festival',
        ),
        icon: Icon(Icons.add),
        backgroundColor: Color(mainColor),
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
