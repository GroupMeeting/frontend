import 'package:flutter/material.dart';
import 'widgets/social_buttons.dart'; // ✅ 소셜 로그인 버튼 import

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            // ID 입력 필드
            TextField(
              decoration: InputDecoration(
                labelText: 'ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // 비밀번호 입력 필드
            TextField(
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),

            // ✅ 로그인 버튼
            ElevatedButton(
            onPressed: () {
              print('[DEBUG] 로그인 버튼 클릭됨');
              if (Navigator.of(context).canPop()) {
                print('[DEBUG] 이미 대시보드가 열려 있음, 이동 생략');
                return;
              }
              Future.delayed(Duration(milliseconds: 300), () {
                if (context.mounted) {
                  print('[DEBUG] 대시보드로 이동');
                  Navigator.of(context).pushReplacementNamed('/dashboard');
                }
              });
            },
            child: Text('로그인', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

            SizedBox(height: 20),

            // 추가 옵션 (아이디 찾기, 비밀번호 찾기, 회원가입)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: () {}, child: Text('아이디 찾기')),
                TextButton(onPressed: () {}, child: Text('비밀번호 찾기')),
                TextButton(onPressed: () {}, child: Text('회원가입')),
              ],
            ),
            SizedBox(height: 30),

            // ✅ 소셜 로그인 버튼
            SocialButtons(),
          ],
        ),
      ),
    );
  }
}