import 'package:flutter/material.dart';

class GroupInviteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('그룹 초대 및 공유')),
      body: Column(
        children: [
          ListTile(
            title: Text('초대 링크 공유'),
            subtitle: Text('그룹 초대 링크를 생성하고 공유하세요.'),
            trailing: Icon(Icons.share),
            onTap: () {
              // 초대 링크 생성 로직 추가
            },
          ),
          ListTile(
            title: Text('QR 코드 공유'),
            subtitle: Text('QR 코드를 스캔하여 그룹에 가입할 수 있습니다.'),
            trailing: Icon(Icons.qr_code),
            onTap: () {
              // QR 코드 생성 로직 추가
            },
          ),
        ],
      ),
    );
  }
}