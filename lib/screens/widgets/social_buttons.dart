import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSocialButton(context, '네이버 아이디로 로그인', Colors.green),
        _buildSocialButton(context, '페이스북 아이디로 로그인', Colors.blue),
        _buildSocialButton(context, '카카오 계정으로 로그인', Colors.amber),
        _buildSocialButton(context, '트위터 아이디로 로그인', Colors.lightBlue),
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
}