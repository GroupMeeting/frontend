 import 'package:flutter/material.dart';
import 'group_chat_screen.dart';
import 'group_manage_screen.dart';

class GroupDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('그룹 상세')),
      body: Column(
        children: [
          ListTile(
            title: Text('그룹 채팅'),
            leading: Icon(Icons.chat),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GroupChatScreen()),
              );
            },
          ),
          ListTile(
            title: Text('그룹 관리'),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GroupManageScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}