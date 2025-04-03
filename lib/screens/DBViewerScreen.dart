import 'package:flutter/material.dart';
// Hive Flutter를 임포트합니다.
import 'package:hive_flutter/hive_flutter.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/models/dongari_model.dart';

class DBViewerScreen extends StatefulWidget {
  const DBViewerScreen({Key? key}) : super(key: key);

  @override
  _DBViewerScreenState createState() => _DBViewerScreenState();
}

class _DBViewerScreenState extends State<DBViewerScreen> {
  late Box<UserModel> _userBox;
  late Box<DongariModel> _dongariBox;

  @override
  void initState() {
    super.initState();
    _openBoxes();
  }

  Future<void> _openBoxes() async {
    _userBox = await Hive.openBox<UserModel>('users');
    _dongariBox = await Hive.openBox<DongariModel>('dongari');
    // 박스가 열리면 화면을 갱신합니다.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Users 탭과 Dongari 탭 2개
      child: Scaffold(
        appBar: AppBar(
          title: const Text('DB 정보보기'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Users'),
              Tab(text: 'Dongari'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUsersTab(),
            _buildDongariTab(),
          ],
        ),
      ),
    );
  }

  /// Users 탭 내용 (ValueListenableBuilder 사용)
  Widget _buildUsersTab() {
    return ValueListenableBuilder(
      valueListenable: _userBox.listenable(),
      builder: (context, Box<UserModel> box, _) {
        final users = box.values.toList();
        if (users.isEmpty) {
          return const Center(child: Text('저장된 사용자 데이터가 없습니다.'));
        }
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final subtitle = '''
이메일: ${user.email}
이름: ${user.name}
비밀번호: ${user.password}
생년월일: ${user.birthDate}
전화번호: ${user.phone}
주소: ${user.address}
''';
            return ListTile(
              title: Text(user.name),
              subtitle: Text(subtitle),
            );
          },
        );
      },
    );
  }

  /// Dongari 탭 내용 (ValueListenableBuilder 사용)
  Widget _buildDongariTab() {
    return ValueListenableBuilder(
      valueListenable: _dongariBox.listenable(),
      builder: (context, Box<DongariModel> box, _) {
        final dongariList = box.values.toList();
        if (dongariList.isEmpty) {
          return const Center(child: Text('저장된 동아리 데이터가 없습니다.'));
        }
        return ListView.builder(
          itemCount: dongariList.length,
          itemBuilder: (context, index) {
            final dongari = dongariList[index];
            // dongari.contacts는 String 리스트로 저장되어 있다고 가정합니다.
            final contactsString = dongari.contacts.join(', ');
            final subtitle = '''
회비날짜: ${dongari.feeDate}
활동지역: ${dongari.region}
이미지경로: ${dongari.imagePath ?? '없음'}
연락처: $contactsString
''';
            return ListTile(
              title: Text(dongari.name),
              subtitle: Text(subtitle),
            );
          },
        );
      },
    );
  }
}