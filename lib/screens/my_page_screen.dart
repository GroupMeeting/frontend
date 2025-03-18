import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings), // 톱니바퀴 아이콘
            onPressed: () {
              // 설정 화면으로 이동
              Navigator.pushNamed(context, '/settings'); // 설정 화면 경로
            },
          ),
        ],
      ),
      body: Center(child: Text('나의 정보 페이지')),
    );
  }
}