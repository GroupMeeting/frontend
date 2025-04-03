import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('설정')),
      body: ListView(
        children: [
          ListTile(
            title: Text('계정 설정'),
            onTap: () {
              // 계정 설정 화면으로 이동
            },
          ),
          ListTile(
            title: Text('알림 설정'),
            onTap: () {
              // 알림 설정 화면으로 이동
            },
          ),
          ListTile(
            title: const Text('로그아웃'),
            onTap: () {
              // 로그아웃 처리: 단순히 로그인 페이지로 이동
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/', // 로그인 화면 라우트 이름
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
} 