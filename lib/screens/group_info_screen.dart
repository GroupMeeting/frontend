import 'package:flutter/material.dart';

class GroupInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('모임')),
      body: Center(child: Text('현재 참여한 모임이 없습니다.')),
    );
  }
} 