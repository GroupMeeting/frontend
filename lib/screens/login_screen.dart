import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:frontend/models/userModel.dart';
import 'package:collection/collection.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;
  
  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  // Hive를 이용한 로그인 함수
  Future<void> _login() async {
    String id = _idController.text.trim();
    String password = _passwordController.text.trim();
    
    // 만약 아이디와 비밀번호가 모두 비어있다면 마스터 계정 사용
    if (id.isEmpty && password.isEmpty) {
      id = "master@example.com";
      password = "masterpass";
    }
    
    debugPrint("🚀 id: $id, password: $password");
    
    // 마스터 계정 검사
    if (id == "master@example.com" && password == "masterpass") {
      Navigator.pushReplacementNamed(context, '/dashboard');
      return;
    }
    
    try {
      // 'users' 박스에서 해당 이메일의 사용자 검색
      var userBox = Hive.box<UserModel>('users');
      // 이메일이 일치하는 사용자 검색, 없으면 null 반환
     final user = userBox.values.firstWhereOrNull((user) => user.email == id);

    if (user == null) {
      setState(() {
        _errorMessage = '등록된 계정이 없습니다.';
      });
      return;
    }

    if (user.password != password) {
      setState(() {
        _errorMessage = '비밀번호가 일치하지 않습니다.';
      });
      return;
    }

    // 로그인 성공 → 대시보드 이동
    Navigator.pushReplacementNamed(context, '/dashboard');
      
    } catch (e) {
      debugPrint("로그인 오류: $e");
      setState(() {
        _errorMessage = '로그인 중 오류가 발생했습니다.';
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("로그인", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              // 이메일 입력 필드
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: '아이디 (이메일)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // 비밀번호 입력 필드
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // 로그인 버튼
              ElevatedButton(
                onPressed: _login,
                child: const Text('로그인', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 20),
              // 회원가입 화면으로 이동
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registration');
                },
                child: const Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}