import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // ✅ 앱 실행 시 로그인 화면부터 시작
      routes: {
        '/': (context) => LoginScreen(), // 로그인 화면이 먼저 보이도록 설정
        '/dashboard': (context) => DashboardScreen(),
      },
    );
  }
}