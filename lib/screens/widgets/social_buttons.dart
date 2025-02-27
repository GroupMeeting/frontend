import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSocialButton(context, '네이버 아이디로 로그인', Colors.green),
        _buildSocialButton(context, '페이스북 아이디로 로그인', Colors.blue),
        _buildSocialButton(context, '카카오 계정으로 로그인', Colors.amber),
        _buildSocialButton(context, '트위터 아이디로 로그인', Colors.lightBlue),
        _buildGoogleSignInButton(context),
      ],
    );
  }

  Widget _buildSocialButton(BuildContext context, String text, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // ✅ 소셜 로그인 API 연동 후 이동하도록 변경
          print('$text 클릭됨'); 
        },
        child: Text(text, style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          try {
            // Google 로그인 시작
            final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
            if (googleUser == null) return;

            // Google 인증 정보 가져오기
            final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

            // Firebase에 Google 로그인 정보 전달
            final OAuthCredential credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );

            // Firebase에 로그인
            await FirebaseAuth.instance.signInWithCredential(credential);
            print('Google 로그인 성공');
          } catch (e) {
            print('Google 로그인 실패: $e');
          }
        },
        child: Text('Google 계정으로 로그인', style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // Google 색상
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}