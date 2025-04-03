import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings), // 톱니바퀴 아이콘
            onPressed: () {
              // 설정 화면으로 이동
              Navigator.pushNamed(context, '/settings'); // 설정 화면 경로
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('나의 정보 페이지'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // DB 정보보기 버튼 → DBViewerScreen 이동
                Navigator.pushNamed(context, '/dbviewer');
              },
              child: const Text('DB 정보보기'),
            ),
          ],
        ),
      ),
    );
  }
}