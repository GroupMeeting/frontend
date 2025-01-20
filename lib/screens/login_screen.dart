import 'package:flutter/material.dart';
import 'calendar_screen.dart'; // 캘린더 페이지 import

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
            SizedBox(height: 50), // 상단 여백 추가
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
              obscureText: true, // 비밀번호 입력시 문자 숨김
            ),
            SizedBox(height: 20),
            // 로그인 버튼
            ElevatedButton(
              onPressed: () {
                // 캘린더 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalendarScreen(), // 캘린더 페이지 연결
                  ),
                );
              },
              child: Text('로그인'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // 버튼 색상 수정
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
            SizedBox(height: 20),
            // 추가 옵션
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('아이디 찾기'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('비밀번호 찾기'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('회원가입'),
                ),
              ],
            ),
            SizedBox(height: 30),
            // 소셜 로그인 버튼
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SocialButton(
                    text: '네이버 아이디로 로그인',
                    color: Colors.green,
                  ),
                  SocialButton(
                    text: '페이스북 아이디로 로그인',
                    color: Colors.blue,
                  ),
                  SocialButton(
                    text: '카카오 계정으로 로그인',
                    color: Colors.amber,
                  ),
                  SocialButton(
                    text: '트위터 아이디로 로그인',
                    color: Colors.lightBlue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String text;
  final Color color;

  const SocialButton({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // 소셜 로그인 로직 추가
        },
        child: Text(text, style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // 버튼 색상 수정
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}