import 'package:flutter/material.dart';
import 'group/group_create_screen.dart';
import 'group/group_detail_screen.dart';

class GroupListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('그룹 목록')),
      body: ListView(
        children: [
          ListTile(
            title: Text('그룹 1'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GroupDetailScreen()),
              );
            },
          ),
          ListTile(
            title: Text('그룹 2'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GroupDetailScreen()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GroupCreateScreen()),
          );
        },
      ),
    );
  }
}