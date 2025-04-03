import 'dart:html';

import 'package:flutter/material.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

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
                    '${baseurl}/images/users/${widget.user!.userImage!}',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
            SizedBox(height: 20.0),
            Text(
              widget.user!.userFullname!,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
