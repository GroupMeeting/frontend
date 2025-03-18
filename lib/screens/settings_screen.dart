import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            title: Text('로그아웃'),
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                final GoogleSignIn googleSignIn = GoogleSignIn();
                await googleSignIn.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (Route<dynamic> route) => false,
                );
              } catch (e) {
                print('로그아웃 실패: $e');
              }
            },
          ),
        ],
      ),
    );
  }
} 