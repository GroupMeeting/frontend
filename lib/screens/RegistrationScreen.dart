import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:frontend/models/userModel.dart';
import 'package:collection/collection.dart'; // collection 패키지 import


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _passwordError;
  
  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _birthDateController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
  
  /// 회원가입 정보를 확인하는 커스텀 모달 표시 함수
  Future<void> _showConfirmationModal() async {
    // 입력한 정보를 문자열로 정리
    final info = '''
아이디 (이메일): ${_idController.text}
이름: ${_nameController.text}
비밀번호: ${_passwordController.text}
생년월일: ${_birthDateController.text}
전화번호: ${_phoneController.text}
주소: ${_addressController.text}
    ''';
    
    // 확인 다이얼로그 표시 (커스텀 모달로 확장 가능)
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('회원가입 확인'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              const Text('다음 정보로 회원가입 하시겠습니까?'),
              const SizedBox(height: 16),
              Text(info),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('아니요'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('네'),
          ),
        ],
      ),
    );
    
    if (confirm == true) {
      // 실제 회원가입 로직: Hive 박스에 사용자 정보 저장
      final userBox = Hive.box<UserModel>('users');
      
      // 이미 해당 이메일의 사용자가 있는지 중복 검사 (firstWhereOrNull 사용)
    final existingUser = userBox.values.firstWhereOrNull(
    (user) => user.email == _idController.text.trim(),
    );

    if (existingUser != null) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이미 존재하는 이메일입니다.')),
    );
    return;
    }
      
      final newUser = UserModel(
        email: _idController.text.trim(),
        name: _nameController.text.trim(),
        password: _passwordController.text.trim(),
        birthDate: _birthDateController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
      );
      
      await userBox.add(newUser);
      debugPrint("회원가입 성공: ${newUser.email}");
      
      // 회원가입 성공 후 로그인 화면이나 대시보드로 이동 (여기선 로그인 화면으로 돌아감)
      Navigator.pop(context);
    }
  }
  
  /// 회원가입 버튼 클릭 시 호출되는 함수
  void _register() {
    if (_formKey.currentState!.validate() && _passwordError == null) {
      _showConfirmationModal();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회원가입"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // 이메일 (아이디) 입력 필드
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: "아이디 (이메일)",
                  border: OutlineInputBorder(),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "이메일을 입력해주세요";
                  }
                  final RegExp emailRegex = RegExp(
                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return "유효한 이메일 주소를 입력해주세요";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // 이름 입력 필드
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "이름",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "이름을 입력해주세요";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // 비밀번호 입력 필드
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "비밀번호",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "비밀번호를 입력해주세요";
                  }
                  if (value.length < 6) {
                    return "비밀번호는 6자 이상이어야 합니다";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // 비밀번호 확인 입력 필드 (실시간 검사)
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: "비밀번호 확인",
                  border: const OutlineInputBorder(),
                  errorText: _passwordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscureConfirmPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  if (value != _passwordController.text) {
                    setState(() {
                      _passwordError = "비밀번호가 일치하지 않습니다";
                    });
                  } else {
                    setState(() {
                      _passwordError = null;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              // 생년월일 입력 필드 (YYYYMMDD 형식, '-' 없이)
              TextFormField(
                controller: _birthDateController,
                decoration: const InputDecoration(
                  labelText: "생년월일 (YYYYMMDD)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "생년월일을 입력해주세요";
                  }
                  if (!RegExp(r'^\d{8}$').hasMatch(value)) {
                    return "YYYYMMDD 형식으로 입력해주세요";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // 전화번호 입력 필드
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: "전화번호",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "전화번호를 입력해주세요";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // 주소 입력 필드
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: "주소",
                  border: OutlineInputBorder(),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "주소를 입력해주세요";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // 회원가입 버튼
              ElevatedButton(
                onPressed: _register,
                child: const Text("회원가입"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}