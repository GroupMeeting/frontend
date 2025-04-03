import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:frontend/models/dongari_model.dart';
import 'package:frontend/models/selectedContact.dart';
import 'package:frontend/screens/widgets/contactPickerDialog.dart';
import 'package:frontend/screens/widgets/imagePickerButton.dart';
import 'package:hive/hive.dart';

class CreateDongariScreen extends StatefulWidget {
  const CreateDongariScreen({Key? key}) : super(key: key);

  @override
  _CreateDongariScreenState createState() => _CreateDongariScreenState();
}

class _CreateDongariScreenState extends State<CreateDongariScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _feeDateController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();

  // 동아리 이미지는 File 타입으로 저장
  File? _selectedImageFile;

  // 선택된 연락처 리스트: SelectedContact 객체를 저장합니다.
  final List<SelectedContact> _selectedContacts = [];

  @override
  void dispose() {
    _nameController.dispose();
    _feeDateController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  // 연락처 선택 함수: 연락처 다이얼로그를 통해 다중 선택
  Future<void> _pickContact() async {
    if (await FlutterContacts.requestPermission()) {
      List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
      showDialog(
        context: context,
        builder: (context) => ContactPickerDialog(
          contacts: contacts,
          onContactsSelected: (List<String> selectedNames, List<String> selectedNumbers) {
            setState(() {
              for (int i = 0; i < selectedNames.length && i < selectedNumbers.length; i++) {
                _selectedContacts.add(
                  SelectedContact(name: selectedNames[i], phone: selectedNumbers[i]),
                );
              }
            });
          },
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('연락처 접근 권한이 필요합니다.')),
      );
    }
  }

  // 동아리 이미지 선택 (모듈화된 ImagePickerButton 사용)
  void _pickImage() {
    // 실제 이미지 피커 구현 시, 선택한 파일을 _selectedImageFile에 저장
    // 임시로 파일 경로를 지정
    setState(() {
      _selectedImageFile = File('path/to/selected_image.jpg');
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('동아리 이미지가 선택되었습니다.')),
    );
  }

  // 동아리 생성 및 DB 저장 함수
  Future<void> _submitDongari() async {
    if (_formKey.currentState!.validate()) {
      debugPrint("동아리 생성 정보:");
      debugPrint("동아리 이름: ${_nameController.text}");
      debugPrint("동아리 이미지: ${_selectedImageFile != null ? _selectedImageFile!.path : '없음'}");
      debugPrint("회비 날짜: ${_feeDateController.text}");
      debugPrint("동아리 활동 지역: ${_regionController.text}");
      final contactsStr = _selectedContacts
          .map((c) => '${c.name} (${c.phone})')
          .join('\n');
      debugPrint("초대 연락처 리스트:\n$contactsStr");

      var dongariBox = Hive.box<DongariModel>('dongari');
      final newDongari = DongariModel(
  name: _nameController.text,
  feeDate: _feeDateController.text,
  region: _regionController.text,
  contacts: _selectedContacts, // 여기서 contacts 사용
  imagePath: _selectedImageFile?.path,
);
      await dongariBox.add(newDongari);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('전송 완료'),
            content: const Text('초대 메시지가 전송되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // 모달 닫기
                  Navigator.pop(context); // 동아리 생성 화면 종료
                },
                child: const Text('닫기'),
              ),
            ],
          );
        },
      );
    }
  }

  // 선택된 연락처를 Chip 위젯으로 표시하는 위젯 (삭제 기능 포함)
  Widget _buildSelectedContactsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _selectedContacts.map((selected) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Chip(
            label: Text('${selected.name} (${selected.phone})'),
            deleteIcon: const Icon(Icons.close),
            onDeleted: () {
              setState(() {
                _selectedContacts.remove(selected);
              });
            },
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('동아리 생성'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // 동아리 이름 입력
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '동아리 이름',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '동아리 이름을 입력해주세요.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // 동아리 이미지 선택
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('동아리 이미지 선택'),
                  ),
                  const SizedBox(width: 16),
                  Text(_selectedImageFile != null
                      ? _selectedImageFile!.path.split('/').last
                      : '선택된 이미지 없음'),
                ],
              ),
              const SizedBox(height: 16),
              // 회비 날짜 입력
              TextFormField(
                controller: _feeDateController,
                decoration: const InputDecoration(
                  labelText: '회비 날짜 (예: 매달 5일)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // 동아리 활동 지역 입력
              TextFormField(
                controller: _regionController,
                decoration: const InputDecoration(
                  labelText: '동아리 활동 지역',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '활동 지역을 입력해주세요.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // 연락처 선택 버튼
              Row(
                children: [
                  const Text('초대 전화번호:'),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _pickContact,
                    child: const Text('연락처 선택'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 선택된 연락처 리스트 (Chip 위젯으로 표시, 삭제 가능)
              _buildSelectedContactsList(),
              const SizedBox(height: 24),
              // 동아리 생성 버튼
              ElevatedButton(
                onPressed: _submitDongari,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('동아리 생성'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}