import 'package:flutter/material.dart';
import 'widgets/social_buttons.dart'; // ✅ 소셜 로그인 버튼 import
import 'package:firebase_auth/firebase_auth.dart';

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
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: 'user@example.com', // 실제 이메일 입력
                    password: 'password', // 실제 비밀번호 입력
                  );
                  print('로그인 성공');
                } catch (e) {
                  print('로그인 실패: $e');
                }
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